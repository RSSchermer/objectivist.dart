part of obj_reading;

/// Enumerates all token types that an [ObjLexer] can output.
enum ObjTokenType {
  // Generic tokens
  string,
  int,
  double,
  comment,
  slash,
  escape,
  newline,

  // Statement start tokens
  vStatementStart,
  vtStatementStart,
  vnStatementStart,
  vpStatementStart,
  cstypeStatementStart,
  degStatementStart,
  bmatStatementStart,
  stepStatementStart,
  pStatementStart,
  lStatementStart,
  fStatementStart,
  curvStatementStart,
  curv2StatementStart,
  surfStatementStart,
  parmStatementStart,
  trimStatementStart,
  holeStatementStart,
  scrvStatementStart,
  spStatementStart,
  endStatementStart,
  conStatementStart,
  gStatementStart,
  sStatementStart,
  mgStatementStart,
  oStatementStart,
  bevelStatementStart,
  cInterpStatementStart,
  dInterpStatementStart,
  lodStatementStart,
  maplibStatementStart,
  usemapStatementStart,
  usemtlStatementStart,
  mtllibStatementStart,
  shadowObjStatementStart,
  traceObjStatementStart,
  ctechStatementStart,
  stechStatementStart,

  // Invalid/unknown tokens
  invalid
}

/// A single lexical `obj` token.
class ObjToken {
  /// This [OjbToken]'s type.
  final ObjTokenType type;

  ///
  final String value;

  /// Instantiates a new [ObjToken].
  ObjToken(this.type, [this.value]);

  String toString() => 'Token($type, $value)';

  bool operator ==(other) =>
      other.identical(this) ||
      other is ObjToken && other.type == type && other.value == value;
}

/// Buffering `obj` lexer.
///
/// Processes characters 1 at the time to build tokens. Tokens will be buffered.
/// See [flush] and [clean] for retrieving the contents of the token buffer.
class ObjLexer {
  /// The character string of the token that is currently being analyzed.
  ///
  /// Grows as more characters get added to the token. Is reset to the empty
  /// string when a token is finished.
  String _currentTokenString = '';

  /// The [ObjTokenType] of the token that is currently being analyzed.
  ///
  /// Starts as [ObjTokenType.invalid] for each token and gets updated as more
  /// characters are processed. Is reset to [ObjTokenType.invalid] when the
  /// token is finished.
  ObjTokenType _currentTokenType = ObjTokenType.invalid;

  /// The currently buffered tokens.
  List<ObjToken> _tokens = [];

  /// Need to track whether or not the lexer is currently in a statement or not
  /// in order to differentiate between string tokens and statement starting
  /// tokens.
  bool _inStatement;

  /// Need to keep track of the last token because the back slash `\` can be
  /// used to escape newlines. An escaped newline does not terminate the
  /// statement (so [_inStatement] should remain `true`), whereas an unescaped
  /// newline always does (so [_inStatement] should be set to `false`).
  ObjToken _lastToken;

  /// Processes the next character.
  ///
  /// Tokens will be buffered. See [flush] and [clean] for retrieving the
  /// contents of the token buffer.
  void process(int charCode) {
    if (_currentTokenType == ObjTokenType.comment) {
      if (charCode == 10 /* Newline, ends comment */) {
        if (_lastToken?.type != ObjTokenType.escape) {
          _inStatement = false;
        }

        _finishCurrentToken();

        _addToken(new ObjToken(ObjTokenType.newline));
      } else {
        _currentTokenString += new String.fromCharCode(charCode);
      }
    } else if (_inStatement) {
      if (charCode == 35 /* # (comment start) */) {
        _finishCurrentToken();

        _currentTokenString = '#';
        _currentTokenType = ObjTokenType.comment;
      } else if (charCode == 10 /* newline */) {
        _finishCurrentToken();

        if (_lastToken?.type != ObjTokenType.escape) {
          _inStatement = false;
        }

        _addToken(new ObjToken(ObjTokenType.newline));
      } else if (charCode == 35 /* space */ || charCode == 9 /* tab */) {
        _finishCurrentToken();
      } else if (charCode >= 97 && charCode <= 122 /* a-z */ ||
          charCode >= 65 && charCode <= 90 /* A-Z */ ||
          charCode == 45 /* - */ ||
          charCode == 95 /* _ */) {
        if (_currentTokenString.length == 0 ||
            _currentTokenType == ObjTokenType.int ||
            _currentTokenType == ObjTokenType.double) {
          _currentTokenType = ObjTokenType.string;
        }

        _currentTokenString += new String.fromCharCode(charCode);

        if (_currentTokenType != ObjTokenType.string) {
          _currentTokenType == ObjTokenType.invalid;
        }
      } else if (charCode >= 47 && charCode <= 57 /* 0-9 */) {
        if (_currentTokenString.length == 0) {
          _currentTokenType = ObjTokenType.int;
        }

        _currentTokenString += new String.fromCharCode(charCode);
      } else if (charCode == 46 /* . */) {
        if (_currentTokenType == ObjTokenType.int ||
            _currentTokenString.length == 0) {
          _currentTokenType = ObjTokenType.double;
        }

        _currentTokenString += '.';

        if (_currentTokenType != ObjTokenType.double &&
            _currentTokenType != ObjTokenType.string) {
          _currentTokenType = ObjTokenType.invalid;
        }
      } else if (charCode == 47 /* / */) {
        _finishCurrentToken();
        _addToken(new ObjToken(ObjTokenType.slash));
      } else if (charCode == 92 /* \ */) {
        _finishCurrentToken();
        _addToken(new ObjToken(ObjTokenType.escape));
      } else {
        _currentTokenString += new String.fromCharCode(charCode);
        _currentTokenType = ObjTokenType.invalid;
      }
    } else {
      if (charCode == 35 /* # */) {
        _finishStatementStartToken();

        _currentTokenString = '#';
        _currentTokenType = ObjTokenType.comment;
      } else if (charCode == 10 /* newline */) {
        _finishStatementStartToken();
        _addToken(new ObjToken(ObjTokenType.newline));
      } else if (charCode == 32 /* space */ || charCode == 9 /* tab */) {
        _finishStatementStartToken();
      } else {
        _currentTokenString += new String.fromCharCode(charCode);
      }
    }
  }

  /// Returns all buffered tokens and empties the token buffer, but leaves any
  /// currently unfinished token intact.
  ///
  /// If this [ObjLexer] currently has a partial unfinished token, then that
  /// token will be preserved. If any other character get processed
  /// subsequently, then these will be used to complete this token and it will
  /// be the first token when the token buffer is flushed again at a later time.
  ///
  /// Use [flush] when lexing a file as multiple streamed chunks. See also
  /// [clean].
  Iterable<ObjToken> flush() {
    final tokens = _tokens;

    _tokens = [];

    return tokens;
  }

  /// Returns all buffered tokens and empties the token buffer and discards any
  /// currently unfinished token.
  ///
  /// If this [ObjLexer] currently has a partial unfinished token, then that
  /// token will be discarded. Essentially resets this [ObjLexer] to its empty
  /// state.
  ///
  /// See also [flush].
  Iterable<ObjToken> clean() {
    final tokens = _tokens;

    _tokens = [];
    _currentTokenString = '';
    _currentTokenType = ObjTokenType.invalid;

    return tokens;
  }

  void _addToken(ObjToken token) {
    _tokens.add(token);
    _lastToken = token;
  }

  void _finishCurrentToken() {
    if (_currentTokenString.length > 0) {
      _addToken(new ObjToken(_currentTokenType, _currentTokenString));
      _currentTokenString = '';
      _currentTokenType = ObjTokenType.invalid;
    }
  }

  void _finishStatementStartToken() {
    if (_currentTokenString.length > 0) {
      final tokenType = _statementStartTokenTypeMap[_currentTokenString];

      if (tokenType != null) {
        _currentTokenType = tokenType;
        _finishCurrentToken();
        _inStatement = true;
      } else {
        _finishCurrentToken();
      }
    }
  }
}

const Map<String, ObjTokenType> _statementStartTokenTypeMap = const {
  'v': ObjTokenType.vStatementStart,
  'vt': ObjTokenType.vtStatementStart,
  'vn': ObjTokenType.vnStatementStart,
  'vp': ObjTokenType.vpStatementStart,
  'cstype': ObjTokenType.cstypeStatementStart,
  'deg': ObjTokenType.degStatementStart,
  'bmat': ObjTokenType.bmatStatementStart,
  'step': ObjTokenType.stepStatementStart,
  'p': ObjTokenType.pStatementStart,
  'l': ObjTokenType.lStatementStart,
  'f': ObjTokenType.fStatementStart,
  'curv': ObjTokenType.curvStatementStart,
  'curv2': ObjTokenType.curv2StatementStart,
  'surf': ObjTokenType.surfStatementStart,
  'parm': ObjTokenType.parmStatementStart,
  'trim': ObjTokenType.trimStatementStart,
  'hole': ObjTokenType.holeStatementStart,
  'scrv': ObjTokenType.scrvStatementStart,
  'sp': ObjTokenType.spStatementStart,
  'end': ObjTokenType.endStatementStart,
  'con': ObjTokenType.conStatementStart,
  'g': ObjTokenType.gStatementStart,
  's': ObjTokenType.sStatementStart,
  'mg': ObjTokenType.mgStatementStart,
  'o': ObjTokenType.oStatementStart,
  'bevel': ObjTokenType.bevelStatementStart,
  'c_interp': ObjTokenType.cInterpStatementStart,
  'd_interp': ObjTokenType.dInterpStatementStart,
  'lod': ObjTokenType.lodStatementStart,
  'maplib': ObjTokenType.maplibStatementStart,
  'usemap': ObjTokenType.usemapStatementStart,
  'usemtl': ObjTokenType.usemtlStatementStart,
  'mtllib': ObjTokenType.mtllibStatementStart,
  'shadow_obj': ObjTokenType.shadowObjStatementStart,
  'trace_obj': ObjTokenType.traceObjStatementStart,
  'ctech': ObjTokenType.ctechStatementStart,
  'stech': ObjTokenType.stechStatementStart
};

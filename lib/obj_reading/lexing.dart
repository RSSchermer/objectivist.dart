library obj_reading.lexing;

import 'dart:async';

/// Enumerates all token types that an [ObjLexer] can output.
enum ObjTokenType {
  string,
  int,
  intPair,
  intTriple,
  double,
  comment,
  backslash,
  newline,
  endOfText,
  invalid
}

/// A single lexical `obj` token.
class ObjToken {
  /// This [ObjToken]'s type.
  final ObjTokenType type;

  /// This [ObjToken]'s value.
  ///
  /// Is `null` for tokens that do cannot have differing values (`slash`,
  /// `backslash`, `newline`).
  final String value;

  /// Instantiates a new [ObjToken].
  ObjToken(this.type, [this.value]);

  String toString() {
    if (value == null) {
      return 'ObjToken($type)';
    } else {
      return 'ObjToken($type, "$value")';
    }
  }

  bool operator ==(other) =>
      identical(other, this) ||
      other is ObjToken && other.type == type && other.value == value;
}

/// Buffering `obj` lexer.
///
/// Processes characters 1 at the time to build tokens. Tokens will be buffered.
/// See [flush] and [clean] for retrieving the contents of the token buffer.
///
/// When finished processing a file or string, call [process] one last time with
/// a character code of `3` ("end of text") to ensure that the lexer finishes
/// the final token.
class ObjLexer {
  /// String buffer for the current token string.
  ///
  /// Gets cleared every time a token is finished.
  StringBuffer _tokenStringBuilder = new StringBuffer();

  /// The [ObjTokenType] of the token that is currently being build.
  ///
  /// Starts as [ObjTokenType.invalid] for each token and gets updated as more
  /// characters are processed. Is reset to [ObjTokenType.invalid] when the
  /// token is finished.
  ObjTokenType _tokenType = ObjTokenType.invalid;

  /// The currently buffered tokens.
  List<ObjToken> _tokens = [];

  int _lastCharCode = 0;

  bool _hasExponent = false;

  /// Processes the next character.
  ///
  /// Tokens will be buffered. See [flush] and [clean] for retrieving the
  /// contents of the token buffer.
  ///
  /// When finished processing a file or string, call [process] one last time
  /// with a [charCode] of `3` ("end of text") to ensure that the lexer finishes
  /// the final token.
  void process(int charCode) {
    if (charCode == 13 /* carriage return */) {
      // Ignore carriage returns
    } else if (charCode == 10 /* newline */) {
      _finishCurrentToken();
      _tokens.add(new ObjToken(ObjTokenType.newline));
    } else if (charCode == 3 /* end of text */) {
      _finishCurrentToken();
      _tokens.add(new ObjToken(ObjTokenType.endOfText));
    } else if (_tokenType == ObjTokenType.comment) {
      _tokenStringBuilder.writeCharCode(charCode);
    } else {
      if (charCode == 35 /* # (comment start) */) {
        _finishCurrentToken();

        _tokenStringBuilder.writeCharCode(35);
        _tokenType = ObjTokenType.comment;
      } else if (charCode == 32 /* space */ || charCode == 9 /* tab */) {
        _finishCurrentToken();
      } else if (charCode == 101 /* e */ || charCode == 69 /* E */) {
        if (_tokenType == ObjTokenType.double && !_hasExponent) {
          _hasExponent = true;
        } else {
          _tokenType = ObjTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode >= 97 && charCode <= 122 /* a-z */ ||
          charCode >= 65 && charCode <= 90 /* A-Z */ ||
          charCode == 95 /* _ */) {
        if (_tokenType == ObjTokenType.int ||
            _tokenType == ObjTokenType.double ||
            _tokenStringBuilder.isEmpty) {
          _tokenType = ObjTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode >= 48 && charCode <= 57 /* 0-9 */) {
        if (_tokenStringBuilder.isEmpty) {
          _tokenType = ObjTokenType.int;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode == 45 /* - */) {
        if (_tokenStringBuilder.isEmpty) {
          _tokenType = ObjTokenType.int;
        } else if (_tokenType == ObjTokenType.int &&
                !(_lastCharCode == 101 /* e */ ||
                    _lastCharCode == 69 /* E */) ||
            _tokenType == ObjTokenType.double &&
                !(_lastCharCode == 101 /* e */ ||
                    _lastCharCode == 69 /* E */) ||
            _tokenType == ObjTokenType.intPair &&
                !(_lastCharCode == 101 /* e */ ||
                    _lastCharCode == 69 /* E */ ||
                    _lastCharCode == 47 /* / */) ||
            _tokenType == ObjTokenType.intTriple &&
                !(_lastCharCode == 101 /* e */ ||
                    _lastCharCode == 69 /* E */ ||
                    _lastCharCode == 47 /* / */)) {
          _tokenType = ObjTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode == 46 /* . */) {
        if (_tokenType == ObjTokenType.int || _tokenStringBuilder.isEmpty) {
          _tokenType = ObjTokenType.double;
        } else {
          _tokenType = ObjTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(46);
      } else if (charCode == 47 /* / */) {
        if (_tokenType == ObjTokenType.int) {
          _tokenType = ObjTokenType.intPair;
        } else if (_tokenType == ObjTokenType.intPair) {
          _tokenType = ObjTokenType.intTriple;
        } else if (_tokenStringBuilder.isEmpty ||
            _tokenType == ObjTokenType.double) {
          _tokenType = ObjTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(47);
      } else if (charCode == 92 /* \ */) {
        if (_tokenStringBuilder.isEmpty) {
          _tokens.add(new ObjToken(ObjTokenType.backslash));
        } else {
          _tokenType = ObjTokenType.string;
          _tokenStringBuilder.writeCharCode(92);
        }
      } else {
        _tokenStringBuilder.writeCharCode(charCode);
        _tokenType = ObjTokenType.invalid;
      }
    }

    _lastCharCode = charCode;
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

  /// Returns all buffered tokens, empties the token buffer and discards any
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
    _tokenStringBuilder.clear();
    _tokenType = ObjTokenType.invalid;
    _lastCharCode = 0;
    _hasExponent = false;

    return tokens;
  }

  void _finishCurrentToken() {
    if (_tokenStringBuilder.isNotEmpty) {
      _tokens.add(new ObjToken(_tokenType, _tokenStringBuilder.toString()));
      _tokenStringBuilder.clear();
      _tokenType = ObjTokenType.invalid;
      _lastCharCode = 0;
      _hasExponent = false;
    }
  }
}

/// Transforms a character stream into a token stream.
class ObjLexerTransformer
    implements StreamTransformer<Iterable<int>, Iterable<ObjToken>> {
  /// The [ObjLexer] used to tokenize the character stream.
  final ObjLexer lexer;

  /// Instantiates a new [ObjLexerTransformer].
  ObjLexerTransformer(this.lexer);

  Stream<Iterable<ObjToken>> bind(Stream<Iterable<int>> stream) {
    final outStreamController = new StreamController<Iterable<ObjToken>>();

    stream.listen((charCodes) {
      for (var charCode in charCodes) {
        lexer.process(charCode);
      }

      outStreamController.add(lexer.flush());
    });

    return outStreamController.stream;
  }
}

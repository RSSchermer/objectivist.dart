library mtl_reading.lexing;

import 'dart:async';

/// Enumerates all token types that an [MtlLexer] can output.
enum MtlTokenType {
  string,
  int,
  double,
  comment,
  backslash,
  newline,
  endOfText,
  invalid
}

/// A single lexical `obj` token.
class MtlToken {
  /// This [MtlToken]'s type.
  final MtlTokenType type;

  /// This [MtlToken]'s value.
  ///
  /// Is `null` for tokens that do cannot have differing values (`slash`,
  /// `backslash`, `newline`).
  final String value;

  /// Instantiates a new [MtlToken].
  MtlToken(this.type, [this.value]);

  String toString() {
    if (value == null) {
      return 'MtlToken($type)';
    } else {
      return 'MtlToken($type, "$value")';
    }
  }

  bool operator ==(other) =>
      identical(other, this) ||
          other is MtlToken && other.type == type && other.value == value;
}

/// Buffering `mtl` lexer.
///
/// Processes characters 1 at the time to build tokens. Tokens will be buffered.
/// See [flush] and [clean] for retrieving the contents of the token buffer.
///
/// When finished processing a file or string, call [process] one last time with
/// a character code of `3` ("end of text") to ensure that the lexer finishes
/// the final token.
class MtlLexer {
  /// String buffer for the current token string.
  ///
  /// Gets cleared every time a token is finished.
  StringBuffer _tokenStringBuilder = new StringBuffer();

  /// The [MtlTokenType] of the token that is currently being build.
  ///
  /// Starts as [MtlTokenType.invalid] for each token and gets updated as more
  /// characters are processed. Is reset to [MtlTokenType.invalid] when the
  /// token is finished.
  MtlTokenType _tokenType = MtlTokenType.invalid;

  /// The currently buffered tokens.
  List<MtlToken> _tokens = [];

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
    if (charCode == 10 /* newline */) {
      _finishCurrentToken();
      _tokens.add(new MtlToken(MtlTokenType.newline));
    } else if (charCode == 3 /* end of text */) {
      _finishCurrentToken();
      _tokens.add(new MtlToken(MtlTokenType.endOfText));
    } else if (_tokenType == MtlTokenType.comment) {
      _tokenStringBuilder.writeCharCode(charCode);
    } else {
      if (charCode == 35 /* # (comment start) */) {
        _finishCurrentToken();

        _tokenStringBuilder.writeCharCode(35);
        _tokenType = MtlTokenType.comment;
      } else if (charCode == 32 /* space */ || charCode == 9 /* tab */) {
        _finishCurrentToken();
      } else if (charCode == 101 /* e */ || charCode == 69 /* E */) {
        if (_tokenType == MtlTokenType.double && !_hasExponent) {
          _hasExponent = true;
        } else {
          _tokenType = MtlTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode >= 97 && charCode <= 122 /* a-z */ ||
          charCode >= 65 && charCode <= 90 /* A-Z */ ||
          charCode == 95 /* _ */) {
        if (_tokenType == MtlTokenType.int ||
            _tokenType == MtlTokenType.double ||
            _tokenStringBuilder.isEmpty) {
          _tokenType = MtlTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode >= 48 && charCode <= 57 /* 0-9 */) {
        if (_tokenStringBuilder.isEmpty) {
          _tokenType = MtlTokenType.int;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode == 45 /* - */) {
        if (_tokenStringBuilder.isEmpty) {
          _tokenType = MtlTokenType.int;
        } else if (_tokenType == MtlTokenType.int &&
            !(_lastCharCode == 101 /* e */ ||
                _lastCharCode == 69 /* E */) ||
            _tokenType == MtlTokenType.double &&
                !(_lastCharCode == 101 /* e */ ||
                    _lastCharCode == 69 /* E */)) {
          _tokenType = MtlTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(charCode);
      } else if (charCode == 46 /* . */) {
        if (_tokenType == MtlTokenType.int || _tokenStringBuilder.isEmpty) {
          _tokenType = MtlTokenType.double;
        } else {
          _tokenType = MtlTokenType.string;
        }

        _tokenStringBuilder.writeCharCode(46);
      } else if (charCode == 47 /* / */) {
        _tokenType = MtlTokenType.string;
        _tokenStringBuilder.writeCharCode(47);
      } else if (charCode == 92 /* \ */) {
        if (_tokenStringBuilder.isEmpty) {
          _tokens.add(new MtlToken(MtlTokenType.backslash));
        } else {
          _tokenType = MtlTokenType.string;
          _tokenStringBuilder.writeCharCode(92);
        }
      } else {
        _tokenStringBuilder.writeCharCode(charCode);
        _tokenType = MtlTokenType.invalid;
      }
    }

    _lastCharCode = charCode;
  }

  /// Returns all buffered tokens and empties the token buffer, but leaves any
  /// currently unfinished token intact.
  ///
  /// If this [MtlLexer] currently has a partial unfinished token, then that
  /// token will be preserved. If any other character get processed
  /// subsequently, then these will be used to complete this token and it will
  /// be the first token when the token buffer is flushed again at a later time.
  ///
  /// Use [flush] when lexing a file as multiple streamed chunks. See also
  /// [clean].
  Iterable<MtlToken> flush() {
    final tokens = _tokens;

    _tokens = [];

    return tokens;
  }

  /// Returns all buffered tokens, empties the token buffer and discards any
  /// currently unfinished token.
  ///
  /// If this [MtlLexer] currently has a partial unfinished token, then that
  /// token will be discarded. Essentially resets this [MtlLexer] to its empty
  /// state.
  ///
  /// See also [flush].
  Iterable<MtlToken> clean() {
    final tokens = _tokens;

    _tokens = [];
    _tokenStringBuilder.clear();
    _tokenType = MtlTokenType.invalid;
    _lastCharCode = 0;
    _hasExponent = false;

    return tokens;
  }

  void _finishCurrentToken() {
    if (_tokenStringBuilder.isNotEmpty) {
      _tokens.add(new MtlToken(_tokenType, _tokenStringBuilder.toString()));
      _tokenStringBuilder.clear();
      _tokenType = MtlTokenType.invalid;
      _lastCharCode = 0;
      _hasExponent = false;
    }
  }
}

/// Transforms a character stream into a token stream.
class MtlLexerTransformer
    implements StreamTransformer<Iterable<int>, Iterable<MtlToken>> {
  /// The [MtlLexer] used to tokenize the character stream.
  final MtlLexer lexer;

  /// Instantiates a new [MtlLexerTransformer].
  MtlLexerTransformer(this.lexer);

  Stream<Iterable<MtlToken>> bind(Stream<Iterable<int>> stream) {
    final outStreamController = new StreamController<Iterable<MtlToken>>();

    stream.listen((charCodes) {
      for (var charCode in charCodes) {
        lexer.process(charCode);
      }

      outStreamController.add(lexer.flush());
    });

    return outStreamController.stream;
  }
}

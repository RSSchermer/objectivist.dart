part of mtl_reading.statement_builders;

abstract class _ColorMapStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  String get statementName;

  List<dynamic> _arguments = [];

  List<MtlReadingError> _errors = [];

  _ColorMapStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    _arguments.add(argument);
  }

  void addIntArgument(int argument) {
    _arguments.add(argument);
  }

  void addDoubleArgument(double argument) {
    _arguments.add(argument);
  }

  MtlStatementResult build() {
    String filename = null;
    bool blendU = true;
    bool blendV = true;
    bool colorCorrection = false;
    bool clamp = false;
    double rangeBase = 0.0;
    double rangeGain = 1.0;
    DoubleTriple originOffset = const DoubleTriple(0.0, 0.0, 0.0);
    DoubleTriple scale = const DoubleTriple(1.0, 1.0, 1.0);
    DoubleTriple turbulence = const DoubleTriple(0.0, 0.0, 0.0);
    int textureResolution = null;

    if (_arguments.last is String) {
      filename = _arguments.last;
    } else {
      _errors.add(new MtlReadingError(
          sourceUri,
          lineNumber,
          'The last argument to a `$statementName` must be a `String` '
          'identifying the map file.'));
    }

    for (var i = 0; i < _arguments.length - 1; i++) {
      switch (_arguments[i]) {
        case '-blendu':
          final a = _arguments[i + 1];

          if (a == 'on') {
            blendU = true;
            i += 1;
          } else if (a == 'off') {
            blendU = false;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'The argument succeeding the `-blendu` option must be either '
                'the string `on` or the string `off`.'));
          }

          break;
        case '-blendv':
          final a = _arguments[i + 1];

          if (a == 'on') {
            blendV = true;
            i += 1;
          } else if (a == 'off') {
            blendV = false;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'The argument succeeding the `-blendv` option must be either '
                'the string `on` or the string `off`.'));
          }

          break;
        case '-cc':
          final a = _arguments[i + 1];

          if (a == 'on') {
            colorCorrection = true;
            i += 1;
          } else if (a == 'off') {
            colorCorrection = false;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'The argument succeeding the `-cc` option must be either '
                'the string `on` or the string `off`.'));
          }

          break;
        case '-clamp':
          final a = _arguments[i + 1];

          if (a == 'on') {
            clamp = true;
            i += 1;
          } else if (a == 'off') {
            clamp = false;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'The argument succeeding the `-clamp` option must be either '
                'the string `on` or the string `off`.'));
          }

          break;
        case '-mm':
          final a = _arguments[i + 1];
          final b = _arguments[i + 2];

          if (a is num) {
            rangeBase = a.toDouble();
            i += 1;

            if (b is num) {
              rangeGain = b.toDouble();
              i += 1;
            }
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'A `-mm` argument must be succeeded by at least one `int` or '
                '`double`.'));
          }

          break;
        case '-o':
          var x = 0.0;
          var y;
          var z;

          final a = _arguments[i + 1];
          final b = _arguments[i + 2];
          final c = _arguments[i + 3];

          if (a is num) {
            x = a.toDouble();
            i += 1;

            if (b is num) {
              y = b.toDouble();
              i += 1;

              if (c is num) {
                z = c.toDouble();
                i += 1;
              }
            }

            originOffset = new DoubleTriple(x, y, z);
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'A `-o` argument must be succeeded by at least one `int` or '
                '`double`.'));
          }

          break;
        case '-s':
          var x = 0.0;
          var y;
          var z;

          final a = _arguments[i + 1];
          final b = _arguments[i + 2];
          final c = _arguments[i + 3];

          if (a is num) {
            x = a.toDouble();
            i += 1;

            if (b is num) {
              y = b.toDouble();
              i += 1;

              if (c is num) {
                z = c.toDouble();
                i += 1;
              }
            }

            scale = new DoubleTriple(x, y, z);
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'A `-s` argument must be succeeded by at least one `int` or '
                '`double`.'));
          }

          break;
        case '-t':
          var x = 0.0;
          var y;
          var z;

          final a = _arguments[i + 1];
          final b = _arguments[i + 2];
          final c = _arguments[i + 3];

          if (a is num) {
            x = a.toDouble();
            i += 1;

            if (b is num) {
              y = b.toDouble();
              i += 1;

              if (c is num) {
                z = c.toDouble();
                i += 1;
              }
            }

            turbulence = new DoubleTriple(x, y, z);
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'A `-t` argument must be succeeded by at least one `int` or '
                '`double`.'));
          }

          break;
        case '-texres':
          final a = _arguments[i + 1];

          if (a is int) {
            textureResolution = a;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(sourceUri, lineNumber,
                'A `-texres` argument must be succeeded by an `int`.'));
          }

          break;
        default:
          _errors.add(new MtlReadingError(
              sourceUri,
              lineNumber,
              'Expected the ${_positionToString(i)} argument of a '
              '`$statementName` statement to be a valid option string, '
              '`${_arguments[i]} given. Valid option strings are: `-blendu`, '
              '`blendv`, `-cc`, `-clamp`, `-mm`, `-o`, `-s`, `-t` and '
              '`-texres`.'));
      }
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(makeStatement(
          filename,
          blendU,
          blendV,
          colorCorrection,
          clamp,
          rangeBase,
          rangeGain,
          originOffset,
          scale,
          turbulence,
          textureResolution,
          lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  MtlStatement makeStatement(
      String filename,
      bool blendU,
      bool blendV,
      bool colorCorrection,
      bool clamp,
      double rangeBase,
      double rangeGain,
      DoubleTriple originOffset,
      DoubleTriple scale,
      DoubleTriple turbulence,
      int textureResolution,
      int lineNumber);
}

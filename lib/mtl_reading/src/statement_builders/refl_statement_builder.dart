part of mtl_reading.statement_builders;

class ReflStatementBuilder implements MtlStatementBuilder {
  final int lineNumber;

  List<dynamic> _arguments = [];

  List<MtlReadingError> _errors = [];

  ReflStatementBuilder(this.lineNumber);

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
    ReflectionMapType type = null;
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
          lineNumber,
          'The last argument to a `refl` must be a `String` '
          'identifying the map file.'));
    }

    for (var i = 0; i < _arguments.length - 1; i++) {
      switch (_arguments[i]) {
        case '-type':
          final a = _arguments[i + 1];

          if (a == 'sphere') {
            type = ReflectionMapType.sphere;
            i += 1;
          } else if (a == 'cube_top') {
            type = ReflectionMapType.cubeTop;
            i += 1;
          } else if (a == 'cube_bottom') {
            type = ReflectionMapType.cubeBottom;
            i += 1;
          } else if (a == 'cube_front') {
            type = ReflectionMapType.cubeFront;
            i += 1;
          } else if (a == 'cube_back') {
            type = ReflectionMapType.cubeBack;
            i += 1;
          } else if (a == 'cube_left') {
            type = ReflectionMapType.cubeLeft;
            i += 1;
          } else if (a == 'cube_right') {
            type = ReflectionMapType.cubeRight;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(
                lineNumber,
                'The argument succeeding the `-type` option must be the string '
                '`sphere`, the string `cube_top`, the string `cube_bottom`, '
                'the string `cube_front`, the string `cube_back`, the string '
                '`cube_left` or the string `cube_right`.'));
          }

          break;
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
            _errors.add(new MtlReadingError(lineNumber,
                'A `-texres` argument must be succeeded by an `int`.'));
          }

          break;
        default:
          _errors.add(new MtlReadingError(
              lineNumber,
              'Expected the ${_positionToString(i)} argument of a `refl` '
              'statement to be a valid option string, `${_arguments[i]} given. '
              'Valid option strings are: `-type`, `-blendu`, `blendv`, `-cc`, '
              '`-clamp`, `-mm`, `-o`, `-s`, `-t` and `-texres`.'));
      }
    }

    if (type == null) {
      _errors.add(new MtlReadingError(lineNumber,
          'The `-type` option must be specified for a `refl` statement.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(new ReflStatement(type, filename,
          blendU: blendU,
          blendV: blendV,
          colorCorrection: colorCorrection,
          clamp: clamp,
          rangeBase: rangeBase,
          rangeGain: rangeGain,
          originOffset: originOffset,
          scale: scale,
          turbulence: turbulence,
          textureResolution: textureResolution,
          lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }
}

part of mtl_reading.statement_builders;

class BumpStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  List<dynamic> _arguments = [];

  List<MtlReadingError> _errors = [];

  BumpStatementBuilder(this.sourceUri, this.lineNumber);

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
    double multiplier = 1.0;
    bool blendU = true;
    bool blendV = true;
    Channel channel = Channel.l;
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
          'The last argument to a `bump` must be a `String` '
          'identifying the map file.'));
    }

    for (var i = 0; i < _arguments.length - 1; i++) {
      switch (_arguments[i]) {
        case '-bm':
          final a = _arguments[i + 1];

          if (a is num) {
            multiplier = a.toDouble();
            i += 1;
          } else {
            _errors.add(new MtlReadingError(sourceUri, lineNumber,
                'A `-bm` argument must be succeeded by an `int` or `double`.'));
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
        case '-imfchan':
          final a = _arguments[i + 1];

          if (a == 'r') {
            channel = Channel.r;
            i += 1;
          } else if (a == 'g') {
            channel = Channel.g;
            i += 1;
          } else if (a == 'b') {
            channel = Channel.b;
            i += 1;
          } else if (a == 'm') {
            channel = Channel.m;
            i += 1;
          } else if (a == 'l') {
            channel = Channel.l;
            i += 1;
          } else if (a == 'z') {
            channel = Channel.z;
            i += 1;
          } else {
            _errors.add(new MtlReadingError(
                sourceUri,
                lineNumber,
                'The argument succeeding the `-imfchan` option must be the '
                'string `r`, the string `g`, the string `b`, the string `m`, '
                'the string `l` or the string `z`.'));
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
              'Expected the ${_positionToString(i)} argument of a `bump` '
              'statement to be a valid option string, `${_arguments[i]} given. '
              'Valid option strings are: `-bm`, `-blendu`, `blendv`, `-cc`, '
              '`-clamp`, `-mm`, `-o`, `-s`, `-t` and `-texres`.'));
      }
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(new BumpStatement(filename,
          multiplier: multiplier,
          blendU: blendU,
          blendV: blendV,
          channel: channel,
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

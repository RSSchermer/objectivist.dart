part of mtl_reading.statement_builders;

enum _ColorStatementBuilderMode { RGB, CIEXYZ, spectral }

abstract class _ColorStatementBuilder implements MtlStatementBuilder {
  final int lineNumber;

  String get statementName;

  double _RGBr;

  double _RGBg;

  double _RGBb;

  double _CIEXYZx;

  double _CIEXYZy;

  double _CIEXYZz;

  String _spectralFilename;

  double _spectralFactor;

  int _argumentCount = 0;

  _ColorStatementBuilderMode _mode;

  List<MtlReadingError> _errors = [];

  _ColorStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        if (argument == 'xyz') {
          _mode = _ColorStatementBuilderMode.CIEXYZ;
        } else if (argument == 'spectral') {
          _mode = _ColorStatementBuilderMode.spectral;
        } else {
          _errors.add(new MtlReadingError(
              lineNumber,
              'The first argument to a `$statementName` statement must be a '
              '`double`, an `int`, the string `xyz` or the string `spectral`.'));
        }
      } else if (_argumentCount == 1) {
        if (_mode == _ColorStatementBuilderMode.spectral) {
          _spectralFilename = argument;
        } else {
          _errors.add(new MtlReadingError(
              lineNumber,
              'The second argument to a `$statementName` statement that is not '
              'marked as `spectral` must be a `double` or an `int`.'));
        }
      } else {
        _errors.add(new ArgumentTypeError(lineNumber, statementName,
            _argumentCount, 'String', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    addDoubleArgument(argument.toDouble());
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _mode = _ColorStatementBuilderMode.RGB;
        _RGBr = argument;
      } else if (_argumentCount == 1) {
        if (_mode == _ColorStatementBuilderMode.RGB) {
          _RGBg = argument;
        } else if (_mode == _ColorStatementBuilderMode.CIEXYZ) {
          _CIEXYZx = argument;
        } else {
          _errors.add(new MtlReadingError(
              lineNumber,
              'The second argument to a `$statementName` statement that is '
              'marked as `spectral` must be a `String`.'));
        }
      } else if (_argumentCount == 2) {
        if (_mode == _ColorStatementBuilderMode.RGB) {
          _RGBb = argument;
        } else if (_mode == _ColorStatementBuilderMode.CIEXYZ) {
          _CIEXYZy = argument;
        } else {
          _spectralFactor = argument;
        }
      } else if (_argumentCount == 3) {
        if (_mode == _ColorStatementBuilderMode.CIEXYZ) {
          _CIEXYZz = argument;
        }
      }
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_mode == _ColorStatementBuilderMode.spectral && _argumentCount < 2) {
      _errors.add(new MtlReadingError(
          lineNumber,
          'A `$statementName` statement marked as `spectral` requires at least '
          '2 arguments.'));
    } else if (_mode == _ColorStatementBuilderMode.CIEXYZ &&
        _argumentCount < 2) {
      _errors.add(new MtlReadingError(
          lineNumber,
          'A `$statementName` statement marked as `xyz` requires at least 2 '
          'arguments.'));
    } else if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(lineNumber,
          'A `$statementName` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      var color;

      if (_mode == _ColorStatementBuilderMode.RGB) {
        color = new RGB(_RGBr, _RGBb ?? _RGBr, _RGBg ?? _RGBr);
      } else if (_mode == _ColorStatementBuilderMode.CIEXYZ) {
        color =
            new CIEXYZ(_CIEXYZx, _CIEXYZy ?? _CIEXYZx, _CIEXYZz ?? _CIEXYZz);
      } else {
        color = new SpectralCurve(_spectralFilename, _spectralFactor ?? 1.0);
      }
      return new MtlStatementResult._success(makeStatement(color, lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  MtlStatement makeStatement(ColorSource color, int lineNumber);

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 4) {
      _errors.add(new MtlReadingError(lineNumber,
          'A `$statementName` statement does not take more than 4 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

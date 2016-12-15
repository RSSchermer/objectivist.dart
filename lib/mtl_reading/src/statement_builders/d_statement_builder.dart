part of mtl_reading.statement_builders;

class DStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  bool _halo = false;

  double _factor;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  DStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        if (argument == '-halo') {
          _halo = true;
        } else {
          _errors.add(new MtlReadingError(
              sourceUri,
              lineNumber,
              'The first argument to a `d` statement must be a `double`, an '
              '`int` or the string `-halo`.'));
        }
      } else {
        _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'd',
            _argumentCount, 'String', ['double', 'int']));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    addDoubleArgument(argument.toDouble());
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _factor = argument;
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_halo && _argumentCount < 2) {
      _errors.add(new MtlReadingError(
          sourceUri,
          lineNumber,
          'A `d` statement with the `-halo` option requires 1 additional '
          'argument.'));
    } else if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(sourceUri, lineNumber,
          'A `d` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new DStatement(_factor, halo: _halo, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 2) {
      _errors.add(new MtlReadingError(sourceUri, lineNumber,
          'A `d` statement does not take more than 2 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

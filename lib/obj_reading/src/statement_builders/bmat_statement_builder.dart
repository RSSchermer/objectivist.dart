part of obj_reading.statement_builders;

class BmatStatementBuilder implements ObjStatementBuilder {
  ParameterDirection _direction;

  List<double> _values = [];

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjReadingError> _errors = [];

  BmatStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount == 0) {
      if (argument == 'u') {
        _direction = ParameterDirection.u;
      } else if (argument == 'v') {
        _direction = ParameterDirection.v;
      } else {
        _errors.add(new ObjReadingError(
            lineNumber,
            'The first argument to a `bmat` statement must be either `u` or '
            '`v`.'));
      }
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'int', ['String']));
    } else {
      _values.add(argument.toDouble());
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'IntPair', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'IntPair', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'IntTriple', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'IntTriple', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'bmat', _argumentCount, 'double', ['String']));
    } else {
      _values.add(argument);
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 2) {
      _errors.add(new ObjReadingError(
          lineNumber, 'A `bmat` statement requires at least 2 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new BmatStatement(_direction, _values, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

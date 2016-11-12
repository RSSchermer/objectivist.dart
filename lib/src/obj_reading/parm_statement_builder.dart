part of obj_reading;

class ParmStatementBuilder implements ObjStatementBuilder {
  ParameterDirection _direction;

  List<double> _values = [];

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors = [];

  ParmStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount == 0) {
      if (argument == 'u') {
        _direction = ParameterDirection.u;
      } else if (argument == 'v') {
        _direction = ParameterDirection.v;
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'The first argument to a `parm` statement must be either `u` or '
            '`v`.'));
      }
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'String', ['double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'int', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'int', ['double']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'IntPair', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'IntPair', ['double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'IntTriple', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'IntTriple', ['double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'parm', _argumentCount, 'double', ['String']));
    } else {
      _values.add(argument);
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 3) {
      _errors.add(new ObjError(
          lineNumber, 'A `parm` statement requires at least 3 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new ParmStatement(_direction, _values, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

part of obj_reading;

class CurvStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  double _start;

  double _end;

  List<int> _vNums = [];

  List<ObjError> _errors = [];

  CurvStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount < 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'String', ['double']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'String', ['int']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount >= 2) {
      _vNums.add(argument);
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'int', ['double']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount < 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntPair', ['double']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntPair', ['int']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount < 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntTriple', ['double']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntTriple', ['int']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_argumentCount == 0) {
      _start = argument;
    } else if (_argumentCount == 1) {
      _end = argument;
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'double', ['int']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 4) {
      _errors.add(new ObjError(
          lineNumber, 'A `curv` statement requires at least 4 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new CurvStatement(_start, _end, _vNums, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

part of obj_reading.statement_builders;

class CurvStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  double _start;

  double _end;

  List<int> _vNums = [];

  List<ObjReadingError> _errors = [];

  CurvStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount < 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'String', ['int', 'double']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'String', ['int']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _start = argument.toDouble();
    } else if (_argumentCount == 1) {
      _end = argument.toDouble();
    } else {
      _vNums.add(argument);
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount < 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntPair', ['int', 'double']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntPair', ['int']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount < 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'curv', _argumentCount, 'IntTriple', ['int', 'double']));
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
      _errors.add(new ObjReadingError(
          lineNumber, 'A `curv` statement requires at least 4 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new CurvStatement(_start, _end, _vNums, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

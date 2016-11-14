part of obj_reading.statement_builders;

enum _LStatementBuilderMode { int, intPair }

class LStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<VertexNumPair> _vNumPairs = [];

  _LStatementBuilderMode _mode;

  List<ObjError> _errors = [];

  LStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'l', _argumentCount, 'String', ['int', 'IntPair']));

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _vNumPairs.add(new VertexNumPair(argument));
      _mode = _LStatementBuilderMode.int;
    } else {
      if (_mode == _LStatementBuilderMode.int) {
        _vNumPairs.add(new VertexNumPair(argument));
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'One `l` statement cannot intermix `int` and `IntPair` arguments; '
            'all arguments must be of the same type.'));
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount == 0) {
      _vNumPairs.add(new VertexNumPair(argument.value1, argument.value2));
      _mode = _LStatementBuilderMode.int;
    } else {
      if (_mode == _LStatementBuilderMode.intPair) {
        _vNumPairs.add(new VertexNumPair(argument.value1, argument.value2));
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'One `l` statement cannot intermix `int` and `IntPair` arguments; '
            'all arguments must be of the same type.'));
      }
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'l', _argumentCount, 'IntTriple', ['int', 'IntPair']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'l', _argumentCount, 'double', ['int', 'IntPair']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 2) {
      _errors.add(new ObjError(
          lineNumber, 'A `l` statement requires at least 2 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new LStatement(_vNumPairs, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

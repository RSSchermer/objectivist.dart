part of obj_reading.statement_builders;

enum _FStatementBuilderMode { int, intPair, intTriple }

class FStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<VertexNumTriple> _vNumTriples = [];

  _FStatementBuilderMode _mode;

  List<ObjError> _errors = [];

  FStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _errors.add(new ArgumentTypeError(lineNumber, 'f', _argumentCount, 'String',
        ['int', 'IntPair', 'IntTriple']));

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _vNumTriples.add(new VertexNumTriple(argument));
      _mode = _FStatementBuilderMode.int;
    } else {
      if (_mode == _FStatementBuilderMode.int) {
        _vNumTriples.add(new VertexNumTriple(argument));
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'One `f` statement cannot intermix `int`, `IntPair` and '
            '`IntTriple` arguments; all arguments must be of the same type.'));
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount == 0) {
      _vNumTriples.add(new VertexNumTriple(argument.value1, argument.value2));
      _mode = _FStatementBuilderMode.intPair;
    } else {
      if (_mode == _FStatementBuilderMode.intPair) {
        _vNumTriples.add(new VertexNumTriple(argument.value1, argument.value2));
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'One `f` statement cannot intermix `int`, `IntPair` and '
            '`IntTriple` arguments; all arguments must be of the same type.'));
      }
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount == 0) {
      _vNumTriples.add(new VertexNumTriple(
          argument.value1, argument.value2, argument.value3));
      _mode = _FStatementBuilderMode.intTriple;
    } else {
      if (_mode == _FStatementBuilderMode.intTriple) {
        _vNumTriples.add(new VertexNumTriple(
            argument.value1, argument.value2, argument.value3));
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'One `f` statement cannot intermix `int`, `IntPair` and '
            '`IntTriple` arguments; all arguments must be of the same type.'));
      }
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(lineNumber, 'f', _argumentCount, 'double',
        ['int', 'IntPair', 'IntTriple']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 3) {
      _errors.add(new ObjError(
          lineNumber, 'A `f` statement requires at least 3 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new FStatement(_vNumTriples, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

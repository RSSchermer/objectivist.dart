part of obj_reading.statement_builders;

enum _SurfStatementBuilderMode { int, intPair, intTriple }

class SurfStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  double _startU;

  double _endU;

  double _startV;

  double _endV;

  List<VertexNumTriple> _controlPointTriples = [];

  _SurfStatementBuilderMode _mode;

  List<ObjReadingError> _errors = [];

  SurfStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount < 4) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'surf', _argumentCount, 'String', ['int', 'double']));
    } else {
      _errors.add(new ArgumentTypeError(lineNumber, 'surf', _argumentCount,
          'String', ['int', 'IntPair', 'IntTriple']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _startU = argument.toDouble();
    } else if (_argumentCount == 1) {
      _endU = argument.toDouble();
    } else if (_argumentCount == 2) {
      _startV = argument.toDouble();
    } else if (_argumentCount == 3) {
      _endV = argument.toDouble();
    } else if (_argumentCount == 4) {
      _controlPointTriples.add(new VertexNumTriple(argument));
      _mode = _SurfStatementBuilderMode.int;
    } else {
      if (_mode == _SurfStatementBuilderMode.int) {
        _controlPointTriples.add(new VertexNumTriple(argument));
      } else {
        _errors.add(new ObjReadingError(
            lineNumber,
            'One `surf` statement cannot intermix `int`, `IntPair` and '
            '`IntTriple` control point arguments; all control point arguments '
            'must be of the same type.'));
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount == 4) {
      _controlPointTriples
          .add(new VertexNumTriple(argument.value1, argument.value2));
      _mode = _SurfStatementBuilderMode.intPair;
    } else if (_argumentCount > 4) {
      if (_mode == _SurfStatementBuilderMode.intPair) {
        _controlPointTriples
            .add(new VertexNumTriple(argument.value1, argument.value2));
      } else {
        _errors.add(new ObjReadingError(
            lineNumber,
            'One `surf` statement cannot intermix `int`, `IntPair` and '
            '`IntTriple` control point arguments; all control point arguments '
            'must be of the same type.'));
      }
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'surf', _argumentCount, 'IntPair', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount == 4) {
      _controlPointTriples.add(new VertexNumTriple(
          argument.value1, argument.value2, argument.value3));
      _mode = _SurfStatementBuilderMode.intTriple;
    } else if (_argumentCount > 4) {
      if (_mode == _SurfStatementBuilderMode.intTriple) {
        _controlPointTriples.add(new VertexNumTriple(
            argument.value1, argument.value2, argument.value3));
      } else {
        _errors.add(new ObjReadingError(
            lineNumber,
            'One `surf` statement cannot intermix `int`, `IntPair` and '
            '`IntTriple` control point arguments; all control point arguments '
            'must be of the same type.'));
      }
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'surf', _argumentCount, 'IntTriple', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_argumentCount == 0) {
      _startU = argument;
    } else if (_argumentCount == 1) {
      _endU = argument;
    } else if (_argumentCount == 2) {
      _startV = argument;
    } else if (_argumentCount == 3) {
      _endV = argument;
    } else {
      _errors.add(new ArgumentTypeError(lineNumber, 'surf', _argumentCount,
          'double', ['int', 'IntPair', 'IntTriple']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 6) {
      _errors.add(new ObjReadingError(
          lineNumber, 'A `surf` statement requires at least 6 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(new SurfStatement(
          _startU, _endU, _startV, _endV, _controlPointTriples,
          lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

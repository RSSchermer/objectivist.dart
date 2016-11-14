part of obj_reading.statement_builders;

class ConStatementBuilder implements ObjStatementBuilder {
  int _surfANum;

  double _startA;

  double _endA;

  int _curv2ANum;

  int _surfBNum;

  double _startB;

  double _endB;

  int _curv2BNum;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors = [];

  ConStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0 ||
          _argumentCount == 3 ||
          _argumentCount == 4 ||
          _argumentCount == 7) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'String', ['int']));
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'String', ['double']));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _surfANum = argument;
      } else if (_argumentCount == 3) {
        _curv2ANum = argument;
      } else if (_argumentCount == 4) {
        _surfBNum = argument;
      } else if (_argumentCount == 7) {
        _curv2BNum = argument;
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'String', ['double']));
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0 ||
          _argumentCount == 3 ||
          _argumentCount == 4 ||
          _argumentCount == 7) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'IntPair', ['int']));
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'IntPair', ['double']));
      }
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0 ||
          _argumentCount == 3 ||
          _argumentCount == 4 ||
          _argumentCount == 7) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'IntTriple', ['int']));
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'IntTriple', ['double']));
      }
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 1) {
        _startA = argument;
      } else if (_argumentCount == 2) {
        _endA = argument;
      } else if (_argumentCount == 5) {
        _startB = argument;
      } else if (_argumentCount == 6) {
        _endB = argument;
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'con', _argumentCount, 'double', ['int']));
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 8) {
      _errors.add(
          new ObjError(lineNumber, 'A `con` statement requires 8 arguments.'));
    }

    if (_errors.isEmpty) {
      final curve2AInstance = new Curve2Instance(_startA, _endA, _curv2ANum);
      final curve2BInstance = new Curve2Instance(_startB, _endB, _curv2BNum);

      return new ObjStatementResult.success(new ConStatement(
          _surfANum, curve2AInstance, _surfBNum, curve2BInstance,
          lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 8) {
      _errors.add(new ObjError(lineNumber,
          'A `con` statement does not take more than 8 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

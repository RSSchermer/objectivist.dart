part of obj_reading;

class StepStatementBuilder implements ObjStatementBuilder {
  int _stepU;

  int _stepV;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors;

  StepStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'step', _argumentCount, 'String', ['int']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _stepU = argument;
      } else if (_argumentCount == 1) {
        _stepV = argument;
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'step', _argumentCount, 'IntPair', ['int']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'step', _argumentCount, 'IntTriple', ['int']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'step', _argumentCount, 'double', ['int']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjError(
          lineNumber, 'A `step` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new StepStatement(_stepU, _stepV, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount > 2) {
      _errors.add(new ObjError(lineNumber,
          'A `step` statement does not take more than 2 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

part of obj_reading.statement_builders;

class StepStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  int _stepU;

  int _stepV;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  StepStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'step', _argumentCount, 'String', ['int']));
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
          sourceUri, lineNumber, 'step', _argumentCount, 'IntPair', ['int']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'step', _argumentCount, 'IntTriple', ['int']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'step', _argumentCount, 'double', ['int']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `step` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new StepStatement(_stepU, _stepV, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 2) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `step` statement does not take more than 2 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

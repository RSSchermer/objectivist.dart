part of obj_reading;

class LodStatementBuilder implements ObjStatementBuilder {
  int _level;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors = [];

  LodStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'deg', _argumentCount, 'String', ['int']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _level = argument;
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'lod', _argumentCount, 'IntPair', ['int']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'lod', _argumentCount, 'IntTriple', ['int']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'lod', _argumentCount, 'double', ['int']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(
          new ObjError(lineNumber, 'An `lod` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new LodStatement(_level, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjError(
          lineNumber, 'An `lod` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

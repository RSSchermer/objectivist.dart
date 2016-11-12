part of obj_reading;

class SpStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<int> _vNums;

  List<ObjError> _errors;

  SpStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'sp', _argumentCount, 'String', ['int']));

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _vNums.add(argument);

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'sp', _argumentCount, 'IntPair', ['int']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'sp', _argumentCount, 'IntTriple', ['int']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'sp', _argumentCount, 'double', ['int']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjError(
          lineNumber, 'An `sp` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new SpStatement(_vNums, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

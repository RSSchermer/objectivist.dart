part of obj_reading.statement_builders;

class PStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<int> _vNums = [];

  List<ObjReadingError> _errors = [];

  PStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'p', _argumentCount, 'String', ['int']));

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _vNums.add(argument);

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'p', _argumentCount, 'IntPair', ['int']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'p', _argumentCount, 'IntTriple', ['int']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'p', _argumentCount, 'double', ['int']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(
          lineNumber, 'A `p` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new PStatement(_vNums, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

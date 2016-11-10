part of obj_reading;

class Curv2StatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<int> _vpNums;

  List<ObjError> _errors;

  Curv2StatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'curv2', _argumentCount, 'String', ['int']));

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _vpNums.add(argument);

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'curv2', _argumentCount, 'IntPair', ['int']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'curv2', _argumentCount, 'IntTriple', ['int']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'curv2', _argumentCount, 'double', ['int']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 2) {
      _errors.add(new ObjError(
          lineNumber, 'A `curv2` statement requires at least 2 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new Curv2Statement(_vpNums, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

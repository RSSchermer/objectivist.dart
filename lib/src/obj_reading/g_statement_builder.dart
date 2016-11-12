part of obj_reading;

class GStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<String> _groupNames = [];

  List<ObjError> _errors = [];

  GStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _groupNames.add(argument);

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'g', _argumentCount, 'int', ['String']));

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'g', _argumentCount, 'IntPair', ['String']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'g', _argumentCount, 'IntTriple', ['String']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'g', _argumentCount, 'double', ['String']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjError(
          lineNumber, 'A `g` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new GStatement(_groupNames, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

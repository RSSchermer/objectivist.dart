part of obj_reading;

class MaplibStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<String> _filenames;

  List<ObjError> _errors;

  MaplibStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _filenames.add(argument);

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'maplib', _argumentCount, 'int', ['String']));

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'maplib', _argumentCount, 'IntPair', ['String']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'maplib', _argumentCount, 'IntTriple', ['String']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'maplib', _argumentCount, 'double', ['String']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjError(
          lineNumber, 'A `maplib` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new MaplibStatement(_filenames, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

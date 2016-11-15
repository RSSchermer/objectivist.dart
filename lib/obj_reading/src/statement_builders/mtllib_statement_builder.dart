part of obj_reading.statement_builders;

class MtllibStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<String> _filenames = [];

  List<ObjReadingError> _errors = [];

  MtllibStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    _filenames.add(argument);

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'mtllib', _argumentCount, 'int', ['String']));

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'mtllib', _argumentCount, 'IntPair', ['String']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'mtllib', _argumentCount, 'IntTriple', ['String']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(
        lineNumber, 'mtllib', _argumentCount, 'double', ['String']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(
          lineNumber, 'A `mtllib` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new MtllibStatement(_filenames, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

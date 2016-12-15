part of obj_reading.statement_builders;

class EndStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  List<ObjReadingError> _errors = [];

  EndStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    _addNoArgumentsError();
  }

  void addIntArgument(int argument) {
    _addNoArgumentsError();
  }

  void addIntPairArgument(IntPair argument) {
    _addNoArgumentsError();
  }

  void addIntTripleArgument(IntTriple argument) {
    _addNoArgumentsError();
  }

  void addDoubleArgument(double argument) {
    _addNoArgumentsError();
  }

  ObjStatementResult build() {
    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new EndStatement(lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  void _addNoArgumentsError() {
    _errors.add(new ObjReadingError(sourceUri, lineNumber,
        'An `end` statement does not take any arguments.'));
  }
}

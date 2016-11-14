part of obj_reading.statement_builders;

class EndStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  List<ObjError> _errors = [];

  EndStatementBuilder(this.lineNumber);

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
      return new ObjStatementResult.success(
          new EndStatement(lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  void _addNoArgumentsError() {
    _errors.add(new ObjError(
        lineNumber, 'An `end` statement does not take any arguments.'));
  }
}

part of obj_reading.statement_builders;

class Curv2StatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  int _argumentCount = 0;

  List<int> _vpNums = [];

  List<ObjReadingError> _errors = [];

  Curv2StatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    _errors.add(new ArgumentTypeError(this.sourceUri, lineNumber, 'curv2',
        _argumentCount, 'String', ['int']));

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    _vpNums.add(argument);

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    _errors.add(new ArgumentTypeError(this.sourceUri, lineNumber, 'curv2',
        _argumentCount, 'IntPair', ['int']));

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    _errors.add(new ArgumentTypeError(this.sourceUri, lineNumber, 'curv2',
        _argumentCount, 'IntTriple', ['int']));

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    _errors.add(new ArgumentTypeError(this.sourceUri, lineNumber, 'curv2',
        _argumentCount, 'double', ['int']));

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 2) {
      _errors.add(new ObjReadingError(this.sourceUri, lineNumber,
          'A `curv2` statement requires at least 2 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new Curv2Statement(_vpNums, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

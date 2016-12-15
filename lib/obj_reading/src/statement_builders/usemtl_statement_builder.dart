part of obj_reading.statement_builders;

class UsemtlStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  String _materialName;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  UsemtlStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _materialName = argument;
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'usemtl', _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'usemtl',
          _argumentCount, 'IntPair', ['String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'usemtl',
          _argumentCount, 'IntTriple', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'usemtl',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(
          sourceUri, lineNumber, 'A `usemtl` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new UsemtlStatement(_materialName, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `usemtl` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

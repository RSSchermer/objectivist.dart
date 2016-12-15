part of obj_reading.statement_builders;

class SStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  int _smoothingGroup;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  SStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (argument == 'off') {
        _smoothingGroup = 0;
      } else {
        _errors.add(new ObjReadingError(
            sourceUri,
            lineNumber,
            'The argument of an `s` must be either an `int` or the value '
            '`off`.'));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _smoothingGroup = argument;
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 's',
          _argumentCount, 'IntPair', ['int', 'String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 's',
          _argumentCount, 'IntTriple', ['int', 'String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 's',
          _argumentCount, 'double', ['int', 'String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(
          sourceUri, lineNumber, 'An `s` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new SStatement(_smoothingGroup, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjReadingError(
          sourceUri, lineNumber, 'An `s` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

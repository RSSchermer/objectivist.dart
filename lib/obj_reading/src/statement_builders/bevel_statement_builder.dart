part of obj_reading.statement_builders;

class BevelStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  bool _bevelEnabled;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  BevelStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (argument == 'on') {
        _bevelEnabled = true;
      } else if (argument == 'off') {
        _bevelEnabled = false;
      } else {
        _errors.add(new ObjReadingError(
            sourceUri,
            lineNumber,
            'The argument supplied to a `bevel` statement must be `on` or '
            '`off`.'));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'bevel', _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'bevel',
          _argumentCount, 'IntPair', ['String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'bevel',
          _argumentCount, 'IntTriple', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'bevel',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(
          sourceUri, lineNumber, 'A `bevel` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new BevelStatement(_bevelEnabled, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjReadingError(
          sourceUri, lineNumber, 'A `bevel` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

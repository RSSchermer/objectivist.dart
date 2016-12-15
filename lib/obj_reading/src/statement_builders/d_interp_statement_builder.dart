part of obj_reading.statement_builders;

class DInterpStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  bool _dissolveInterpolationEnabled;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  DInterpStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (argument == 'on') {
        _dissolveInterpolationEnabled = true;
      } else if (argument == 'off') {
        _dissolveInterpolationEnabled = false;
      } else {
        _errors.add(new ObjReadingError(
            sourceUri,
            lineNumber,
            'The argument supplied to a `d_interp` statement must be `on` or '
            '`off`.'));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'd_interp',
          _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'd_interp',
          _argumentCount, 'IntPair', ['String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'd_interp',
          _argumentCount, 'IntTriple', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'd_interp',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `d_interp` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(new DInterpStatement(
          _dissolveInterpolationEnabled,
          lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `d_interp` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

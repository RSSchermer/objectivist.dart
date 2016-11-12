part of obj_reading;

class CInterpStatementBuilder implements ObjStatementBuilder {
  bool _colorInterpolationEnabled;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors = [];

  CInterpStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (argument == 'on') {
        _colorInterpolationEnabled = true;
      } else if (argument == 'off') {
        _colorInterpolationEnabled = false;
      } else {
        _errors.add(new ObjError(
            lineNumber,
            'The argument supplied to a `c_interp` statement must be `on` or '
            '`off`.'));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'c_interp', _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'c_interp', _argumentCount, 'IntPair', ['String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'c_interp', _argumentCount, 'IntTriple', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'c_interp', _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjError(
          lineNumber, 'A `c_interp` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(new CInterpStatement(
          _colorInterpolationEnabled,
          lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjError(
          lineNumber, 'A `c_interp` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

part of obj_reading;

class SStatementBuilder implements ObjStatementBuilder {
  int _smoothingGroup;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors = [];

  SStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (argument == 'off') {
        _smoothingGroup = 0;
      } else {
        _errors.add(new ObjError(
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
      _errors.add(new ArgumentTypeError(
          lineNumber, 's', _argumentCount, 'IntPair', ['int', 'String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 's', _argumentCount, 'IntTriple', ['int', 'String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 's', _argumentCount, 'double', ['int', 'String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(
          new ObjError(lineNumber, 'An `s` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new SStatement(_smoothingGroup, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(
          new ObjError(lineNumber, 'An `s` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

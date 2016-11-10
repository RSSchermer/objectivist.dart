part of obj_reading;

class VnStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  double _i;

  double _j;

  double _k;

  List<ObjError> _errors;

  VnStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vn', _argumentCount, 'String', ['double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vn', _argumentCount, 'int', ['double']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vn', _argumentCount, 'IntPair', ['double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vn', _argumentCount, 'IntTriple', ['double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _i = argument;
      } else if (_argumentCount == 1) {
        _j = argument;
      } else if (_argumentCount == 2) {
        _k = argument;
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(
          new ObjError(lineNumber, 'A `vn` statement requires 3 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new VnStatement(_i, _j, _k, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount > 3) {
      _errors.add(new ObjError(
          lineNumber, 'A `vn` statement does not take more than 3 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

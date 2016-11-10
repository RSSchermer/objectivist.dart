part of obj_reading;

class VpStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  double _u;

  double _v;

  double _w;

  List<ObjError> _errors;

  VpStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vp', _argumentCount, 'String', ['double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vp', _argumentCount, 'Int', ['double']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vp', _argumentCount, 'IntPair', ['double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'vp', _argumentCount, 'IntTriple', ['double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _u = argument;
      } else if (_argumentCount == 1) {
        _v = argument;
      } else if (_argumentCount == 2) {
        _w = argument;
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjError(
          lineNumber, 'A `vp` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new VtStatement(_u, _v, _w, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount > 3) {
      _errors.add(new ObjError(
          lineNumber, 'A `vp` statement does not take more than 3 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

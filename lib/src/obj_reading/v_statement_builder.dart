part of obj_reading;

class VStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  double _x;

  double _y;

  double _z;

  double _w;

  List<ObjError> _errors;

  VStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'v', _argumentCount, 'String', ['double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'v', _argumentCount, 'int', ['double']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'v', _argumentCount, 'IntPair', ['double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'v', _argumentCount, 'IntTriple', ['double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _x = argument;
      } else if (_argumentCount == 1) {
        _y = argument;
      } else if (_argumentCount == 2) {
        _z = argument;
      } else if (_argumentCount == 3) {
        _w = argument;
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 3) {
      _errors.add(new ObjError(
          lineNumber, 'A `v` statement requires at least 3 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult.success(
          new VStatement(_x, _y, _z, _w, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount > 4) {
      _errors.add(new ObjError(
          lineNumber, 'A `v` statement does not take more than 4 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

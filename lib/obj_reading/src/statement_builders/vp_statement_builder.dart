part of obj_reading.statement_builders;

class VpStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  int _argumentCount = 0;

  double _u;

  double _v;

  double _w;

  List<ObjReadingError> _errors = [];

  VpStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'vp',
          _argumentCount, 'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _u = argument.toDouble();
      } else if (_argumentCount == 1) {
        _v = argument.toDouble();
      } else if (_argumentCount == 2) {
        _w = argument.toDouble();
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'vp',
          _argumentCount, 'IntPair', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'vp',
          _argumentCount, 'IntTriple', ['int', 'double']));
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
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `vp` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new VpStatement(_u, _v, _w, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 3) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `vp` statement does not take more than 3 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

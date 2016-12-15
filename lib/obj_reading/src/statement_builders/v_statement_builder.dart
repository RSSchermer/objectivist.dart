part of obj_reading.statement_builders;

class VStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  int _argumentCount = 0;

  double _x;

  double _y;

  double _z;

  double _w;

  List<ObjReadingError> _errors = [];

  VStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'v',
          _argumentCount, 'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _x = argument.toDouble();
      } else if (_argumentCount == 1) {
        _y = argument.toDouble();
      } else if (_argumentCount == 2) {
        _z = argument.toDouble();
      } else if (_argumentCount == 3) {
        _w = argument.toDouble();
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'v',
          _argumentCount, 'IntPair', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'v',
          _argumentCount, 'IntTriple', ['int', 'double']));
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
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `v` statement requires at least 3 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new VStatement(_x, _y, _z, _w, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 4) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `v` statement does not take more than 4 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

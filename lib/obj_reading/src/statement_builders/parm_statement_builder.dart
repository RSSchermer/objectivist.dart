part of obj_reading.statement_builders;

class ParmStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  ParameterDirection _direction;

  List<double> _values = [];

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  ParmStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount == 0) {
      if (argument == 'u') {
        _direction = ParameterDirection.u;
      } else if (argument == 'v') {
        _direction = ParameterDirection.v;
      } else {
        _errors.add(new ObjReadingError(
            sourceUri,
            lineNumber,
            'The first argument to a `parm` statement must be either `u` or '
            '`v`.'));
      }
    } else {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'parm',
          _argumentCount, 'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'parm', _argumentCount, 'int', ['String']));
    } else {
      _values.add(argument.toDouble());
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'parm',
          _argumentCount, 'IntPair', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'parm',
          _argumentCount, 'IntPair', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'parm',
          _argumentCount, 'IntTriple', ['String']));
    } else {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'parm',
          _argumentCount, 'IntTriple', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_argumentCount == 0) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'parm', _argumentCount, 'double', ['String']));
    } else {
      _values.add(argument);
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 3) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `parm` statement requires at least 3 arguments.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new ParmStatement(_direction, _values, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }
}

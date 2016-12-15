part of obj_reading.statement_builders;

class MgStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  int _mergingGroup;

  double _resolution;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  MgStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        if (argument == 'off') {
          _mergingGroup = 0;
        } else {
          _errors.add(new ObjReadingError(
              sourceUri,
              lineNumber,
              'The argument of an `mg` must be either an `int` or the value '
              '`off`.'));
        }
      } else {
        _errors.add(new ArgumentTypeError(
            sourceUri, lineNumber, 'mg', _argumentCount, 'String', ['double']));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _mergingGroup = argument;
      } else {
        _errors.add(new ArgumentTypeError(
            sourceUri, lineNumber, 'mg', _argumentCount, 'int', ['double']));
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'mg',
            _argumentCount, 'IntPair', ['int', 'String']));
      } else {
        _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'mg',
            _argumentCount, 'IntPair', ['double']));
      }
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'mg',
            _argumentCount, 'IntTriple', ['int', 'String']));
      } else {
        _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'mg',
            _argumentCount, 'IntTriple', ['double']));
      }
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 1) {
        _resolution = argument;
      } else {
        _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'mg',
            _argumentCount, 'double', ['int', 'String']));
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_mergingGroup > 0 && _argumentCount < 2) {
      _errors.add(new ObjReadingError(
          sourceUri,
          lineNumber,
          'An `mg` statement does not turn off smoothing groups requires a '
          'second resolution argument.'));
    } else if (_mergingGroup <= 0 && _argumentCount < 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'An `mg` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new MgStatement(_mergingGroup, _resolution, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 2) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'An `mg` statement does not take more than 2 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

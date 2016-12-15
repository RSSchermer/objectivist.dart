part of obj_reading.statement_builders;

class TraceObjStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  String _filename;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  TraceObjStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _filename = argument;
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'trace_obj',
          _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'trace_obj',
          _argumentCount, 'IntPair', ['String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'trace_obj',
          _argumentCount, 'IntTriple', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'trace_obj',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `trace_obj` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(
          new TraceObjStatement(_filename, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `trace_obj` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

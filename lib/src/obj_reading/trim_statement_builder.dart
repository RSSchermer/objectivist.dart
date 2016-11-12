part of obj_reading;

class TrimStatementBuilder implements ObjStatementBuilder {
  final int lineNumber;

  int _argumentCount = 0;

  List<double> _starts;

  List<double> _ends;

  List<int> _curv2Nums;

  List<ObjError> _errors;

  TrimStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_argumentCount % 3 == 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'String', ['int']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'String', ['double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_argumentCount % 3 == 2) {
      _curv2Nums.add(argument);
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'int', ['double']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_argumentCount % 3 == 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'IntPair', ['int']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'IntPair', ['double']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_argumentCount % 3 == 2) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'IntTriple', ['int']));
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'IntTriple', ['double']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_argumentCount % 3 == 0) {
      _starts.add(argument);
    } else if (_argumentCount % 3 == 1) {
      _ends.add(argument);
    } else {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'trim', _argumentCount, 'double', ['int']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_argumentCount < 3) {
      _errors.add(new ObjError(
          lineNumber, 'A `trim` statement requires at least 3 arguments.'));
    } else if (_argumentCount % 3 != 0) {
      _errors.add(new ObjError(
          lineNumber,
          'The number of arguments supplied to a `trim` statement must be '
          'multiple of 3.'));
    }

    if (_errors.isEmpty) {
      final curve2Instances = <Curve2Instance>[];

      for (var i = 0; i * 3 < _argumentCount; i++) {
        curve2Instances
            .add(new Curve2Instance(_starts[i], _ends[i], _curv2Nums[i]));
      }

      return new ObjStatementResult.success(
          new TrimStatement(curve2Instances, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }
}

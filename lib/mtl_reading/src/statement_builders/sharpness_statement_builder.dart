part of mtl_reading.statement_builders;

class SharpnessStatementBuilder implements MtlStatementBuilder {
  final int lineNumber;

  num _sharpness;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  SharpnessStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(lineNumber, 'sharpness', _argumentCount,
          'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _sharpness = argument;
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _sharpness = argument;
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(
          lineNumber, 'A `sharpness` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new SharpnessStatement(_sharpness, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new MtlReadingError(
          lineNumber, 'A `sharpness` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

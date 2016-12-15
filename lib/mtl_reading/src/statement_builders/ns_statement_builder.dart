part of mtl_reading.statement_builders;

class NsStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  num _exponent;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  NsStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'Ns',
          _argumentCount, 'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _exponent = argument;
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _exponent = argument;
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(
          sourceUri, lineNumber, 'A `Ns` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new NsStatement(_exponent, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new MtlReadingError(
          sourceUri, lineNumber, 'A `Ns` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

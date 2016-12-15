part of mtl_reading.statement_builders;

class NiStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  double _opticalDensity;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  NiStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'Ni',
          _argumentCount, 'String', ['int', 'double']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    addDoubleArgument(argument.toDouble());
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _opticalDensity = argument;
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(
          sourceUri, lineNumber, 'A `Ni` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new NiStatement(_opticalDensity, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new MtlReadingError(
          sourceUri, lineNumber, 'A `Ni` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

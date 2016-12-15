part of mtl_reading.statement_builders;

class NewmtlStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  String _materialName;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  NewmtlStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _materialName = argument;
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'newmtl', _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'newmtl',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(
          sourceUri, lineNumber, 'A `newmtl` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new NewmtlStatement(_materialName, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new MtlReadingError(sourceUri, lineNumber,
          'A `newmtl` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

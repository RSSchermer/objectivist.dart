part of mtl_reading.statement_builders;

class MapAatStatementBuilder implements MtlStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  bool _antialiasingEnabled;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  MapAatStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (argument == 'on') {
        _antialiasingEnabled = true;
      } else if (argument == 'off') {
        _antialiasingEnabled = false;
      } else {
        _errors.add(new MtlReadingError(
            sourceUri,
            lineNumber,
            'The argument of a `map_aat` statement should be either the string '
            '`on` or the string `off`.'));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'map_aat', _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'map_aat',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(
          sourceUri, lineNumber, 'A `map_aat` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new MapAatStatement(_antialiasingEnabled, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new MtlReadingError(sourceUri, lineNumber,
          'A `map_aat` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}

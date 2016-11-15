library obj_reading.errors;

/// An error encountered while reading an `.obj` file.
class ObjReadingError {
  /// The lineNumber at which this [ObjReadingError] occurred.
  final int lineNumber;

  /// A description of the error.
  final String description;

  /// Instantiates a new [ObjReadingError].
  ObjReadingError(this.lineNumber, this.description);

  String toString() => 'Error on line $lineNumber: $description';
}

///
class ArgumentTypeError implements ObjReadingError {
  /// The line at which the statement occurred.
  final int lineNumber;

  /// The statement type in which the argument
  final String statementType;

  /// The position of the argument in the statement's argument list.
  final int argumentPosition;

  /// The incorrect actual type that was used as the argument value.
  final String actualType;

  /// The correct types for the argument value.
  final Iterable<String> expectedTypes;

  /// Instantiates a new [ArgumentTypeError].
  ArgumentTypeError(this.lineNumber, this.statementType, this.argumentPosition,
      this.actualType, this.expectedTypes);

  String get description {
    final positionString = _positionToString(argumentPosition);
    final expectedList = expectedTypes.toList();

    var expectedString = '`${expectedList[0]}`';

    for (var i = 1; i < expectedList.length; i++) {
      if (i == expectedTypes.length - 1) {
        expectedString += ' or `${expectedList[i]}`';
      } else {
        expectedString += ', `${expectedList[i]}`';
      }
    }

    return 'The $positionString argument of a(n) `$statementType` statement '
        'must be a(n) $expectedString; `$actualType` given.';
  }

  String toString() => 'Error on line $lineNumber: $description';
}

String _positionToString(int position) {
  final adjusted = position + 1;

  switch (adjusted % 10) {
    case 1:
      return '${adjusted}st';
    case 2:
      return '${adjusted}nd';
    default:
      return '${adjusted}th';
  }
}

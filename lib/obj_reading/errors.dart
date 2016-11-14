library obj_reading.errors;

class ObjError {
  final int lineNumber;

  final String description;

  ObjError(this.lineNumber, this.description);

  String toString() => 'Error on line $lineNumber: $description';
}

class ArgumentTypeError implements ObjError {
  final int lineNumber;

  final String statementType;

  final int argumentPosition;

  final String actualType;

  final Iterable<String> expectedTypes;

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

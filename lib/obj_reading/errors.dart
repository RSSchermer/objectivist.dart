library obj_reading.errors;

import 'package:objectivist/errors.dart';

/// An error encountered while reading an `.obj` file.
class ObjReadingError implements ReadingError {
  final Uri sourceUri;

  final int lineNumber;

  final String description;

  /// Instantiates a new [ObjReadingError].
  ObjReadingError(this.sourceUri, this.lineNumber, this.description);

  String toString() => 'Error on line $lineNumber: $description';
}

/// An [ObjReading] error used to describe errors that occur when incorrect
/// arguments are read for a statement.
class ArgumentTypeError implements ObjReadingError {
  final Uri sourceUri;

  final int lineNumber;

  /// The statement type for which this [ArgumentTypeError] occurred.
  final String statementType;

  /// The position of the argument in the statement's argument list.
  final int argumentPosition;

  /// The incorrect actual type that was used as the argument value.
  final String actualType;

  /// The correct types for the argument value.
  final Iterable<String> expectedTypes;

  /// Instantiates a new [ArgumentTypeError].
  ArgumentTypeError(this.sourceUri, this.lineNumber, this.statementType,
      this.argumentPosition, this.actualType, this.expectedTypes);

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

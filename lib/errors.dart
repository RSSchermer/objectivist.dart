library errors;

/// An error encountered while reading a file.
abstract class ReadingError {
  /// The [Uri] of the file in which the error occurred.
  Uri get sourceUri;

  /// The lineNumber at which this [ObjReadingError] occurred.
  int get lineNumber;

  /// A description of the error.
  String get description;
}

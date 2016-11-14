part of obj_statements;

/// State setting statement specifies an object name for the elements that
/// follow it.
class OStatement implements ObjStatement {
  /// The object name set by this [OStatement].
  final String objectName;

  final int lineNumber;

  /// Instantiates a new [OStatement].
  OStatement(this.objectName, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitOStatement(this);
  }

  String toSource() => 'o $objectName';

  String toString() => 'OStatement($objectName, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is OStatement &&
          other.objectName == objectName &&
          other.lineNumber == lineNumber;
}

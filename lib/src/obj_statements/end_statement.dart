part of obj_statements;

/// Specifies the end of a body statement block for free-form geometry (curves
/// and surfaces).
class EndStatement implements ObjStatement {
  final int lineNumber;

  /// Instantiates a new [EndStatement].
  EndStatement({this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitEndStatement(this);
  }

  String toSource() => 'end';

  String toString() => 'EndStatement(lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is EndStatement && other.lineNumber == lineNumber;
}

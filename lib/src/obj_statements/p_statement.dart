part of obj_statements;

/// Specifies point elements by referencing their vertices.
///
/// You can specify multiple points with this statement.
class PStatement implements ObjStatement {
  /// The reference numbers of the geometric vertices that define the points.
  ///
  /// Should contain at least 1 reference number.
  final Iterable<int> vNums;

  final int lineNumber;

  /// Instantiates a new [PStatement].
  PStatement(this.vNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitPStatement(this);
  }

  String toSource() =>
      vNums.map((n) => n.toString()).fold('p', (res, s) => '$res $s');

  String toString() => 'PStatement($vNums, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is PStatement &&
          listsEqual(other.vNums.toList(), vNums.toList()) &&
          other.lineNumber == lineNumber;
}

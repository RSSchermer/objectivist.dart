part of obj_statements;

/// Specifies a line element by its [VertexNumPair]s.
class LStatement implements ObjStatement {
  /// The [VertexNumPair]s that define the line.
  ///
  /// Should contain at least 2 [VertexNumPair]s.
  final Iterable<VertexNumPair> vertexNumPairs;

  final int lineNumber;

  /// Instantiates a new [LStatement].
  LStatement(this.vertexNumPairs, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitLStatement(this);
  }

  String toSource() =>
      vertexNumPairs.map((n) => n.toSource()).fold('l', (res, s) => '$res $s');

  String toString() => 'LStatement($vertexNumPairs, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is LStatement &&
          listsEqual(other.vertexNumPairs.toList(), vertexNumPairs.toList()) &&
          other.lineNumber == lineNumber;
}

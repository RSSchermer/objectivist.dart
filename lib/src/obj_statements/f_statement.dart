part of obj_statements;

/// Specifies a face element by its [VertexNumTriple]s.
class FStatement implements ObjStatement {
  /// The [VertexNumTriple]s that define the face.
  ///
  /// Should contain at least 3 [VertexNumTriple]s.
  final Iterable<VertexNumTriple> vertexNumTriples;

  final int lineNumber;

  /// Instantiates a new [FStatement].
  FStatement(this.vertexNumTriples, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitFStatement(this);
  }

  String toSource() => vertexNumTriples
      .map((n) => n.toSource())
      .fold('f', (res, s) => '$res $s');

  String toString() => 'FStatement($vertexNumTriples, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is FStatement &&
          listsEqual(
              other.vertexNumTriples.toList(), vertexNumTriples.toList()) &&
          other.lineNumber == lineNumber;
}

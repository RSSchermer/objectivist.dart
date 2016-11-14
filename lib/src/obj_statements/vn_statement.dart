part of obj_statements;

/// Specifies a normal vector with components [i], [j], and [k].
///
/// Vertex normals affect the smooth-shading and rendering of geometry. For
/// polygons, vertex normals are used in place of the actual facet normals. For
/// surfaces, vertex normals are interpolated over the entire surface and
/// replace the actual analytic surface normal.
///
/// When vertex normals are present, they supersede smoothing groups.
class VnStatement implements ObjStatement {
  /// The first component of the normal vector.
  final double i;

  /// The second component of the normal vector.
  final double j;

  /// The third component of the normal vector.
  final double k;

  final int lineNumber;

  /// Instantiates a new [VertexNormal].
  VnStatement(this.i, this.j, this.k, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVnStatement(this);
  }

  String toSource() => 'vn $i $j $k';

  String toString() => 'VnStatement($i, $j, $k, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is VnStatement &&
          other.i == i &&
          other.j == j &&
          other.k == k &&
          other.lineNumber == lineNumber;
}

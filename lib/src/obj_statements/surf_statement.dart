part of obj_statements;

/// Specifies a surface, its parameter range, and its control vertices.
///
/// The surface is evaluated within the global parameter range from [startU] to
/// [endU] in the `u` direction and from [startV] to [endV] in the `v`
/// direction.
class SurfStatement implements ObjStatement {
  /// The starting parameter value for the curve in the `u` direction.
  final double startU;

  /// The ending parameter value for the curve in the `u` direction.
  final double endU;

  /// The starting parameter value for the curve in the `v` direction.
  final double startV;

  /// The ending parameter value for the curve in the `v` direction.
  final double endV;

  /// The [VertexNumTriple]s that act as the control points for the surface.
  ///
  /// For a non-rational surface, the control vertices are 3D.  For a rational
  /// surface the control vertices can be 3D or 4D.  The fourth coordinate
  /// (weight) defaults to 1.0 if omitted.
  ///
  /// For more information on the ordering of control points for surfaces, refer
  /// to the section on surfaces and control points in "mathematics of free-form
  /// curves/surfaces" at the end of the OBJ 3.0 specification.
  final Iterable<VertexNumTriple> controlPointTriples;

  final int lineNumber;

  /// Instantiates a new [SurfStatement].
  SurfStatement(
      this.startU, this.endU, this.startV, this.endV, this.controlPointTriples,
      {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitSurfStatement(this);
  }

  String toSource() => controlPointTriples
      .map((n) => n.toSource())
      .fold('surf $startU $endU $startV $endV', (res, s) => '$res $s');

  String toString() =>
      'SurfStatement($startU, $endU, $startV, $endV, $controlPointTriples, '
      'lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SurfStatement &&
          other.startU == startU &&
          other.endU == endU &&
          other.startV == startV &&
          other.endV == endV &&
          listsEqual(other.controlPointTriples.toList(),
              controlPointTriples.toList()) &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

/// Specifies a curve, its parameter range, and its control vertices.
class CurvStatement implements ObjStatement {
  /// The starting parameter value for the curve.
  final double start;

  /// The ending parameter value for the curve.
  final double end;

  /// The reference numbers of the geometric vertices that act as the control
  /// points for the curve.
  ///
  /// For a non-rational curve, the control points must be 3D. For a rational
  /// curve, the control points are 3D or 4D. The fourth coordinate (weight)
  /// defaults to 1.0 if omitted.
  ///
  /// A minimum of two control points are required.
  final Iterable<int> controlPointNums;

  final int lineNumber;

  /// Instantiates a new [CurvStatement].
  CurvStatement(this.start, this.end, this.controlPointNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCurvStatement(this);
  }

  String toSource() => controlPointNums
      .map((n) => n.toString())
      .fold('curv $start $end', (res, s) => '$res $s');

  String toString() =>
      'CurvStatement($start, $end, $controlPointNums, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CurvStatement &&
          other.start == start &&
          other.end == end &&
          listsEqual(
              other.controlPointNums.toList(), controlPointNums.toList()) &&
          other.lineNumber == lineNumber;
}

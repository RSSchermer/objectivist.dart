part of obj_statements;

/// Specifies a 2D curve on a surface and its control points.
///
/// A 2D curve is used as an outer or inner trimming curve, as a special curve,
/// or for connectivity.
class Curv2Statement implements ObjStatement {
  /// The reference numbers of the parameter space vertices that act as the
  /// control points for the curve.
  ///
  /// A minimum of two control points are required.
  final Iterable<int> controlPointNums;

  final int lineNumber;

  /// Instantiates a new [Curv2Statement].
  Curv2Statement(this.controlPointNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCurv2Statement(this);
  }

  String toSource() => controlPointNums
      .map((n) => n.toString())
      .fold('curv2', (res, s) => '$res $s');

  String toString() =>
      'Curv2Statement($controlPointNums, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is Curv2Statement &&
          listsEqual(
              other.controlPointNums.toList(), controlPointNums.toList()) &&
          other.lineNumber == lineNumber;
}

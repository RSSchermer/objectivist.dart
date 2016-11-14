part of obj_statements;

/// Body statement for a surface that specifies a sequence of curves which lie
/// on the given surface to build a single special curve.
///
/// Each special curve should be included in any triangulation of the surface.
/// This means that the line formed by approximating the special curve with a
/// sequence of straight line segments should actually appear as a sequence of
/// triangle edges in the final triangulation of the surface.
class ScrvStatement implements ObjStatement {
  /// The [Curve2Instance]s that define the special curve.
  final Iterable<Curve2Instance> curves;

  final int lineNumber;

  /// Instantiates a new [ScrvStatement].
  ScrvStatement(this.curves, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitScrvStatement(this);
  }

  String toSource() =>
      curves.map((n) => n.toSource()).fold('scrv', (res, s) => '$res $s');

  String toString() => 'ScrvStatement($curves, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is ScrvStatement &&
          listsEqual(other.curves.toList(), curves.toList()) &&
          other.lineNumber == lineNumber;
}

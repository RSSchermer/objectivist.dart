part of obj_statements;

/// Specifies a point in the parameter space of a curve or surface.
///
/// The usage determines how many coordinates are required. Special points for
/// curves require a 1D control point ([u] only) in the parameter space of the
/// curve. Special points for surfaces require a 2D point ([u] and [v]) in the
/// parameter space of the surface. Control points for non-rational trimming
/// curves require [u] and [v] coordinates. Control points for rational trimming
/// curves require [u], [v], and [w] (weight) coordinates.
class VpStatement implements ObjStatement {
  /// The point in the parameter space of a curve or the first coordinate in
  /// the parameter space of a surface.
  final double u;

  /// The second coordinate in the parameter space of a surface.
  final double v;

  /// The weight required for rational trimming curves.
  ///
  /// If you do not specify a value for `w`, it defaults to `1.0`.
  final double w;

  final int lineNumber;

  // TODO: make v and w  optional positional arguments once Dart allows both
  // optional named and optional positional arguments in the same argument list.

  /// Instantiates a new [ParameterSpaceVertex].
  VpStatement(this.u, this.v, this.w, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVpStatement(this);
  }

  String toSource() {
    if (v != null) {
      if (w != null) {
        return 'vp $u $v $w';
      } else {
        return 'vp $u $v';
      }
    } else {
      return 'vp $u';
    }
  }

  String toString() => 'VpStatement($u, $v, $w, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is VpStatement &&
          other.u == u &&
          other.v == v &&
          other.w == w &&
          other.lineNumber == lineNumber;
}

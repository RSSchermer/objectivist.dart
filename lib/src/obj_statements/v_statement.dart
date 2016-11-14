part of obj_statements;

/// Specifies a geometric vertex and its [x], [y] and [z] coordinates.
///
/// Rational curves and surfaces require a fourth homogeneous coordinate [w],
/// also called the weight.
class VStatement implements ObjStatement {
  /// The `x` coordinate of the vertex.
  ///
  /// Together with [y] and [z] defines the position of the vertex in 3
  /// dimensions.
  final double x;

  /// The `y` coordinate of the vertex.
  ///
  /// Together with [x] and [z] defines the position of the vertex in 3
  /// dimensions.
  final double y;

  /// The `z` coordinate of the vertex.
  ///
  /// Together with [x] and [y] defines the position of the vertex in 3
  /// dimensions.
  final double z;

  /// Weight required for rational curves and surfaces.
  ///
  /// Is not required for non-rational curves and surfaces. If you do not
  /// specify a value for w, then the default should be `1.0`.
  final double w;

  final int lineNumber;

  // TODO: make w an optional positional argument once Dart allows both optional
  // named and optional positional arguments in the same argument list.

  /// Instantiates a new [VStatement].
  VStatement(this.x, this.y, this.z, this.w, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVStatement(this);
  }

  String toSource() {
    if (w != null) {
      return 'v $x $y $z $w';
    } else {
      return 'v $x $y $z';
    }
  }

  String toString() => 'VStatement($x, $y, $z, $w, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is VStatement &&
          other.x == x &&
          other.y == y &&
          other.z == z &&
          other.w == w &&
          other.lineNumber == lineNumber;
}

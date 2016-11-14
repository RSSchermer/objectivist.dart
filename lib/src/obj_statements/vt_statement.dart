part of obj_statements;

/// Specifies a texture vertex and its coordinates.
///
/// A 1D texture requires only the [u] texture coordinate, a 2D texture requires
/// both [u] and [v] texture coordinates, and a 3D texture requires [u], [v] and
/// [w] texture coordinates.
class VtStatement implements ObjStatement {
  /// The texture vertex coordinate in the horizontal direction of the texture.
  final double u;

  /// The texture vertex coordinate in the vertical direction of the texture.
  ///
  /// Only used for 2D and 3D textures.
  final double v;

  /// The texture vertex coordinate in the depth direction of the texture.
  ///
  /// Only used for 3D textures.
  final double w;

  final int lineNumber;

  /// Instantiates a new [VtStatement].
  VtStatement(this.u, this.v, this.w, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVtStatement(this);
  }

  String toSource() {
    if (v != null) {
      if (w != null) {
        return 'vt $u $v $w';
      } else {
        return 'vt $u $v';
      }
    } else {
      return 'vt $u';
    }
  }

  String toString() => 'VtStatement($u, $v, $w, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is VtStatement &&
          other.u == u &&
          other.v == v &&
          other.w == w &&
          other.lineNumber == lineNumber;
}

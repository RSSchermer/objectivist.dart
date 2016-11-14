part of obj_statements;

/// State setting statement that turns color interpolation on or off.
///
/// Color interpolation creates a blend across the surface of a polygon between
/// the materials assigned to its vertices. This creates a blending of colors
/// across a face element.
///
/// To support color interpolation, materials must be assigned per vertex, not
/// per element. The illumination models for all materials of vertices attached
/// to the polygon must be the same. Color interpolation applies to the values
/// for ambient (`Ka`), diffuse (`Kd`), specular (`Ks`), and specular highlight
/// (`Ns`) material properties.
class CInterpStatement implements ObjStatement {
  /// Whether this [CInterpStatement] enabled or disabled color interpolation.
  final bool colorInterpolationEnabled;

  final int lineNumber;

  /// Instantiates a new [CInterpStatement].
  CInterpStatement(this.colorInterpolationEnabled, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCInterpStatement(this);
  }

  String toSource() {
    if (colorInterpolationEnabled) {
      return 'c_interp on';
    } else {
      return 'c_interp off';
    }
  }

  String toString() =>
      'CInterpStatement($colorInterpolationEnabled, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CInterpStatement &&
          other.colorInterpolationEnabled == colorInterpolationEnabled &&
          other.lineNumber == lineNumber;
}

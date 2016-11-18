part of mtl_statements;

/// Specifies the dissolve for the current material.
///
/// If no dissolve is specified for a material, the material should be fully
/// opaque.
class DStatement implements MtlStatement {
  /// The amount this material dissolves into the background.
  ///
  /// A factor of `1.0` is fully opaque. A factor of `0.0` is fully dissolved
  /// (completely transparent).
  final double factor;

  /// Whether or not the dissolve is dependent on the surface orientation
  /// relative to the viewer.
  ///
  /// For example, if `true` for a sphere with a dissolve of `0.0`, then the
  /// sphere should be fully dissolved at its center and should appear gradually
  /// more opaque toward its edge.
  final bool halo;

  final int lineNumber;

  /// Instantiates a new [DStatement].
  DStatement(this.factor, {this.halo, this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitDStatement(this);
  }

  String toSource() => 'd $factor';

  String toString() => 'DStatement($factor, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is DStatement &&
          other.factor == factor &&
          other.lineNumber == lineNumber;
}

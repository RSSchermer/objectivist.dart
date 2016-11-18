part of mtl_statements;

/// Turns on anti-aliasing of textures in this material without anti-aliasing
/// all textures in the scene.
class MapAatStatement implements MtlStatement {
  /// Whether or not this [MapAatStatement] enabled antialiasing.
  final bool antialiasingEnabled;

  final int lineNumber;

  /// Instantiates a new [MapAatStatement].
  MapAatStatement(this.antialiasingEnabled, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitMapAatStatement(this);
  }

  String toSource() {
    if (antialiasingEnabled) {
      return 'map_aat on';
    } else {
      return 'map_aat off';
    }
  }

  String toString() =>
      'MapAatStatement($antialiasingEnabled, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is MapAatStatement &&
          other.antialiasingEnabled == antialiasingEnabled &&
          other.lineNumber == lineNumber;
}

part of mtl_statements;

/// Specifies the diffuse reflectivity of a material.
class KdStatement implements MtlStatement {
  /// The color composition that is used to determine the fraction of incoming
  /// light that should be reflected.
  final ColorSource reflectionColor;

  final int lineNumber;

  /// Instantiates a new [KdStatement].
  KdStatement(this.reflectionColor, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitKdStatement(this);
  }

  String toSource() => 'Kd ${reflectionColor.toSource()}';

  String toString() => 'KdStatement($reflectionColor, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is KdStatement &&
          other.reflectionColor == reflectionColor &&
          other.lineNumber == lineNumber;
}

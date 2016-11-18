part of mtl_statements;

/// Specifies the specular reflectivity of a material.
class KsStatement implements MtlStatement {
  /// The color composition that is used to determine the fraction of incoming
  /// light that should be reflected.
  final ColorSource reflectionColor;

  final int lineNumber;

  /// Instantiates a new [KsStatement].
  KsStatement(this.reflectionColor, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitKsStatement(this);
  }

  String toSource() => 'Ks ${reflectionColor.toSource()}';

  String toString() => 'KsStatement($reflectionColor, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is KsStatement &&
          other.reflectionColor == reflectionColor &&
          other.lineNumber == lineNumber;
}

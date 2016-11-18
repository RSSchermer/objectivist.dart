part of mtl_statements;

/// Specifies the ambient reflectivity of a material.
class KaStatement implements MtlStatement {
  /// The color composition that is used to determine the fraction of incoming
  /// light that should be reflected.
  final ColorSource reflectionColor;

  final int lineNumber;

  /// Instantiates a new [KaStatement].
  KaStatement(this.reflectionColor, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitKaStatement(this);
  }

  String toSource() => 'Ka ${reflectionColor.toSource()}';

  String toString() => 'KaStatement($reflectionColor, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is KaStatement &&
          other.reflectionColor == reflectionColor &&
          other.lineNumber == lineNumber;
}

part of mtl_statements;

/// Specifies the transmission factor of a material.
///
/// Any light passing through the object is filtered by the transmission filter,
/// which only allows specific colors to pass through.
class TfStatement implements MtlStatement {
  /// The color composition that is used to determine the fraction of incoming
  /// light that should be transmitted.
  final ColorSource transmissionColor;

  final int lineNumber;

  /// Instantiates a new [TfStatement].
  TfStatement(this.transmissionColor, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitTfStatement(this);
  }

  String toSource() => 'Tf ${transmissionColor.toSource()}';

  String toString() =>
      'TfStatement($transmissionColor, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is TfStatement &&
          other.transmissionColor == transmissionColor &&
          other.lineNumber == lineNumber;
}

part of mtl_statements;

/// Specifies the specular exponent for the current material.
///
/// The specular exponent controls the focus of specular highlights. The higher
/// the exponent, the tighter and more concentrated the highlight.
class NsStatement implements MtlStatement {
  /// The value for the specular exponent.
  ///
  /// A high exponent results in a tight, concentrated highlight. Ns values
  /// normally range from `0` to `1000`.
  final int exponent;

  final int lineNumber;

  /// Instantiates a new [NsStatement].
  NsStatement(this.exponent, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitNsStatement(this);
  }

  String toSource() => 'Ns $exponent';

  String toString() => 'NsStatement($exponent, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is NsStatement &&
          other.exponent == exponent &&
          other.lineNumber == lineNumber;
}

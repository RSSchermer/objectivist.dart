part of mtl_statements;

/// Specifies the start of a material description and assigns a name to the
/// material.
///
/// An `.mtl` file must have one [NewmtlStatement] at the start of each material
/// description.
class NewmtlStatement implements MtlStatement {
  /// The name of the material.
  ///
  /// Names may be any length but cannot include blanks. Underscores may be used
  /// in material names.
  final String materialName;

  final int lineNumber;

  /// Instantiates a new [NewmtlStatement].
  NewmtlStatement(this.materialName, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitNewmtlStatement(this);
  }

  String toSource() => 'newmtl $materialName';

  String toString() =>
      'NewmtlStatement($materialName, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is NewmtlStatement &&
          other.materialName == materialName &&
          other.lineNumber == lineNumber;
}

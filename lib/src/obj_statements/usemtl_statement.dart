part of obj_statements;

/// State setting statement that specifies the material for the elements
/// following it.
///
/// Once a material is assigned, it cannot be turned off; it can only be
/// changed.
class UsemtlStatement implements ObjStatement {
  /// The name of the texture map.
  final String materialName;

  final int lineNumber;

  /// Instantiates a new [UsemtlStatement].
  UsemtlStatement(this.materialName, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitUsemtlStatement(this);
  }

  String toSource() => 'usemtl $materialName';

  String toString() =>
      'UsemtlStatement($materialName, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is UsemtlStatement &&
          other.materialName == materialName &&
          other.lineNumber == lineNumber;
}

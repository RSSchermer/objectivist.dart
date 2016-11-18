part of mtl_statements;

/// Specifies the sharpness of the reflections from the local reflection map.
///
/// If a material does not have a local reflection map defined in its material
/// definition, then this statement may apply to a global reflection map. A high
/// [sharpness] results in a clear reflection of objects in the reflection map.
///
/// If no [SharpnessStatement] is specified for a material, then a default
/// sharpness of `60` should be used.
class SharpnessStatement implements MtlStatement {
  /// The sharpness value specified by this [SharpnessStatement].
  ///
  /// Can be a number from 0 to 1000.
  final int sharpness;

  final int lineNumber;

  /// Instantiates a new [SharpnessStatement].
  SharpnessStatement(this.sharpness, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitSharpnessStatement(this);
  }

  String toSource() => 'sharpness $sharpness';

  String toString() => 'Sharpness($sharpness, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SharpnessStatement &&
          other.sharpness == sharpness &&
          other.lineNumber == lineNumber;
}

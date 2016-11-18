part of mtl_statements;

/// Specifies the optical density for the material.
///
/// This is also known as index of refraction.
///
/// The [opticalDensity] can range from `0.001` to `10`. A value of `1.0` means
/// that light does not bend as it passes through an object. Increasing the
/// [opticalDensity] increases the amount of bending. Glass has an index of
/// refraction of about `1.5`. Values of less than `1.0` produce bizarre results
/// and are not recommended.
class NiStatement implements MtlStatement {
  /// The optical density (index of refraction) specified by this [NiStatement].
  ///
  /// The value can range from `0.001` to `10`. A value of `1.0` means that
  /// light does not bend as it passes through an object. Increasing the value
  /// increases the amount of bending. Glass has an index of refraction of about
  /// `1.5`. Values of less than `1.0` produce bizarre results and are not
  /// recommended.
  final double opticalDensity;

  final int lineNumber;

  /// Instantiates a new [NiStatement].
  NiStatement(this.opticalDensity, {this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitNiStatement(this);
  }

  String toSource() => 'Ni $opticalDensity';

  String toString() => 'NiStatement($opticalDensity, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is NiStatement &&
          other.opticalDensity == opticalDensity &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

/// Enumerates the available approximation techniques for free-form curve
/// geometry.
enum CTech {
  constantParametricSubdivision,
  constantSpatialSubdivision,
  curvatureDependentSubdivision
}

/// State setting statement that specifies a curve approximation technique.
class CtechStatement implements ObjStatement {
  /// The [CurveApproximationTechnique] specified by this [CTechStatement].
  final CurveApproximationTechnique technique;

  final int lineNumber;

  /// Instantiates a new [CtechStatement].
  CtechStatement(this.technique, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCtechStatement(this);
  }

  String toSource() => 'ctech ${technique.toSource()}';

  String toString() => 'CtechStatement($technique, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CtechStatement &&
          other.technique == technique &&
          other.lineNumber == lineNumber;
}

/// Base class for techniques that can be used to approximate free-form curves
/// with line segments.
///
/// See [CurveConstantParametricSubdivision], [CurveConstantSpatialSubdivision]
/// and [CurveCurvatureDependentSubdivision].
abstract class CurveApproximationTechnique {
  /// The type of approximation technique used.
  CTech get type;

  /// A valid `.obj` source string representation of this
  /// [CurveApproximationTechnique].
  String toSource();
}

/// Curve constant parametric subdivision using one resolution parameter.
///
/// Each polynomial segment of the curve is subdivided `n` times in parameter
/// space, where `n` is the [resolution] multiplied by the degree of the curve.
class CurveConstantParametricSubdivision
    implements CurveApproximationTechnique {
  final CTech type = CTech.constantParametricSubdivision;

  /// The approximation resolution.
  ///
  /// Each polynomial segment of the curve is subdivided `n` times in parameter
  /// space, where `n` is the resolution multiplied by the degree of the curve.
  ///
  /// The larger the value, the finer the resolution. If the value is `0.0`,
  /// then each polynomial curve segment is represented by a single line
  /// segment.
  final double resolution;

  /// Creates a new [CurveConstantParametricSubdivision] instance.
  CurveConstantParametricSubdivision(this.resolution);

  String toSource() => 'cparm $resolution';

  String toString() => 'CurveConstantParametricSubdivision($resolution)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CurveConstantParametricSubdivision &&
          other.resolution == resolution;
}

/// Curve constant spatial subdivision.
///
/// The curve is approximated by a series of line segments whose lengths in real
/// space are less than or equal to the [maxLength].
class CurveConstantSpatialSubdivision implements CurveApproximationTechnique {
  final CTech type = CTech.constantSpatialSubdivision;

  /// The maximum length of the line segments.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxLength;

  /// Creates a new [CurveConstantSpatialSubdivision] instance.
  CurveConstantSpatialSubdivision(this.maxLength);

  String toSource() => 'cspace $maxLength';

  String toString() => 'CurveConstantSpatialSubdivision($maxLength)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CurveConstantSpatialSubdivision && other.maxLength == maxLength;
}

/// Curve curvature-dependent subdivision using separate resolution parameters
/// for the maximum distance and the maximum angle.
///
/// The curve is approximated by a series of line segments in which 1) the
/// distance in object space between a line segment and the actual curve must be
/// less than the [maxDistance] and 2) the angle in degrees between tangent
/// vectors at the ends of a line segment must be less than the [maxAngle].
class CurveCurvatureDependentSubdivision
    implements CurveApproximationTechnique {
  final CTech type = CTech.curvatureDependentSubdivision;

  /// The maximum allowed distance in real space between a line segment and the
  /// actual curve.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxDistance;

  /// The maximum allowed angle (in degrees) between tangent vectors at the ends
  /// of a line segment.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxAngle;

  /// Creates a new [CurveCurvatureDependentSubdivision] instance.
  CurveCurvatureDependentSubdivision(this.maxDistance, this.maxAngle);

  String toSource() => 'curve $maxDistance $maxAngle';

  String toString() =>
      'CurveCurvatureDependentSubdivision($maxDistance, $maxAngle)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CurveCurvatureDependentSubdivision &&
          other.maxDistance == maxDistance &&
          other.maxAngle == maxAngle;
}

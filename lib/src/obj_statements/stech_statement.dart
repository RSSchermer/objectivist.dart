part of obj_statements;

/// Enumerates the available approximation techniques for free-form surface
/// geometry.
enum STech {
  constantParametricSubdivisionA,
  constantParametricSubdivisionB,
  constantSpatialSubdivision,
  curvatureDependentSubdivision
}

/// State setting statement that specifies a surface approximation technique.
class StechStatement implements ObjStatement {
  /// The [SurfaceApproximationTechnique] specified by this [StechStatement].
  final SurfaceApproximationTechnique technique;

  final int lineNumber;

  /// Instantiates a new [StechStatement].
  StechStatement(this.technique, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitStechStatement(this);
  }

  String toSource() => 'stech ${technique.toSource()}';

  String toString() => 'StechStatement($technique, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is StechStatement &&
          other.technique == technique &&
          other.lineNumber == lineNumber;
}

/// Base class for techniques that can be used to approximate free-form surfaces
/// with triangle patches.
///
/// See [SurfaceConstantParametricSubdivisionA],
/// [SurfaceConstantParametricSubdivisionB], [SurfaceConstantSpatialSubdivision]
/// and [SurfaceCurvatureDependentSubdivision].
abstract class SurfaceApproximationTechnique {
  /// The type of approximation technique used.
  STech get type;

  /// A valid `.obj` source string representation of this
  /// [SurfaceApproximationTechnique].
  String toSource();
}

/// Surface constant parametric subdivision using separate resolution parameters
/// for the `u` and `v` directions.
///
/// Each patch of the surface is subdivided `n` times in parameter space, where
/// `n` is the resolution parameter multiplied by the degree of the surface.
///
/// See also [SurfaceConstantParametricSubdivisionB].
class SurfaceConstantParametricSubdivisionA
    implements SurfaceApproximationTechnique {
  final STech type = STech.constantParametricSubdivisionA;

  /// The approximation resolution for the `u` direction.
  ///
  /// The larger the value, the finer the resolution. If you enter a value of
  /// `0.0` for both [resolutionU] and [resolutionV], then each patch is
  /// approximated by two triangles.
  final double resolutionU;

  /// The approximation resolution for the `v` direction.
  ///
  /// The larger the value, the finer the resolution. If you enter a value of
  /// `0.0` for both [resolutionU] and [resolutionV], then each patch is
  /// approximated by two triangles.
  final double resolutionV;

  /// Creates a new [SurfaceConstantParametricSubdivisionA] instance.
  SurfaceConstantParametricSubdivisionA(this.resolutionU, this.resolutionV);

  String toSource() => 'cparma $resolutionU $resolutionV';

  String toString() =>
      'SurfaceConstantParametricSubdivisionA($resolutionU, $resolutionV)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SurfaceConstantParametricSubdivisionA &&
          other.resolutionU == resolutionU &&
          other.resolutionV == resolutionV;
}

/// Surface constant parametric subdivision using a single resolution parameter
/// for both the `u` and `v` directions.
///
/// An initial triangulation is performed using only the points on the trimming
/// curves. This triangulation is then refined until all edges are of an
/// appropriate length. The resulting triangles are not oriented along
/// isoparametric lines as they are in when using the
/// [SurfaceConstantParametricSubdivisionA] technique.
///
/// See also [SurfaceConstantParametricSubdivisionA].
class SurfaceConstantParametricSubdivisionB
    implements SurfaceApproximationTechnique {
  final STech type = STech.constantParametricSubdivisionA;

  /// The approximation resolution.
  ///
  /// The larger the value, the finer the resolution.
  final double resolution;

  /// Creates a new [SurfaceConstantParametricSubdivisionB] instance.
  SurfaceConstantParametricSubdivisionB(this.resolution);

  String toSource() => 'cparmb $resolution';

  String toString() => 'SurfaceConstantParametricSubdivisionB($resolution)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SurfaceConstantParametricSubdivisionB &&
          other.resolution == resolution;
}

/// Surface constant spatial subdivision.
///
/// The surface is subdivided in rectangular regions until the length in real
/// space of any rectangle edge is less than the [maxLength]. These rectangular
/// regions are then triangulated.
class SurfaceConstantSpatialSubdivision
    implements SurfaceApproximationTechnique {
  final STech type = STech.constantSpatialSubdivision;

  /// The maximum allowed length in real space of any rectangle edge.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxLength;

  /// Creates a new [SurfaceConstantSpatialSubdivision] instance.
  SurfaceConstantSpatialSubdivision(this.maxLength);

  String toSource() => 'cspace $maxLength';

  String toString() => 'SurfaceConstantSpatialSubdivision($maxLength)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SurfaceConstantSpatialSubdivision &&
          other.maxLength == maxLength;
}

/// Surface curvature-dependent subdivision using separate resolution parameters
/// for the maximum distance and the maximum angle.
///
/// The surface is subdivided in rectangular regions until 1) the distance in
/// real space between the approximating rectangle and the actual surface is
/// less than the [maxDistance] (approximately) and 2) the angle in degrees
/// between surface normals at the corners of the rectangle is less than the
/// [maxAngle]. Following subdivision, the regions are triangulated.
class SurfaceCurvatureDependentSubdivision
    implements SurfaceApproximationTechnique {
  final STech type = STech.curvatureDependentSubdivision;

  /// The maximum allowed distance in real space between the approximating
  /// rectangle and the actual surface.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxDistance;

  /// The maximum allowed angle in degrees between surface normals at the
  /// corners of the rectangle.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxAngle;

  /// Creates a new [SurfaceCurvatureDependentSubdivision] instance.
  SurfaceCurvatureDependentSubdivision(this.maxDistance, this.maxAngle);

  String toSource() => 'curve $maxDistance $maxAngle';

  String toString() =>
      'SurfaceCurvatureDependentSubdivision($maxDistance, $maxAngle)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SurfaceCurvatureDependentSubdivision &&
          other.maxDistance == maxDistance &&
          other.maxAngle == maxAngle;
}

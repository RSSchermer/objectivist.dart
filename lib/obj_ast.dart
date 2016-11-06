library obj_ast;

import 'package:rl_matrix/rl_matrix.dart';

/// Specifies a geometric vertex and its [x], [y] and [z] coordinates.
///
/// Rational curves and surfaces require a fourth homogeneous coordinate [w],
/// also called the weight.
class GeometricVertex {
  /// The `x` coordinate of the vertex.
  ///
  /// Together with [y] and [z] defines the position of the vertex in 3
  /// dimensions.
  final double x;

  /// The `y` coordinate of the vertex.
  ///
  /// Together with [x] and [z] defines the position of the vertex in 3
  /// dimensions.
  final double y;

  /// The `z` coordinate of the vertex.
  ///
  /// Together with [x] and [y] defines the position of the vertex in 3
  /// dimensions.
  final double z;

  /// Weight required for rational curves and surfaces.
  ///
  /// Is not required for non-rational curves and surfaces. If you do not
  /// specify a value for w, the default is 1.0.
  final double w;

  // TODO: make w an optional positional argument once Dart allows both optional
  // named and optional positional arguments in the same argument list.

  /// Instantiates a new [GeometricVertex].
  GeometricVertex(this.x, this.y, this.z, [this.w = 1.0]);
}

/// Specifies a point in the parameter space of a curve or surface.
///
/// The usage determines how many coordinates are required. Special points for
/// curves require a 1D control point ([u] only) in the parameter space of the
/// curve. Special points for surfaces require a 2D point ([u] and [v]) in the
/// parameter space of the surface. Control points for non-rational trimming
/// curves require [u] and [v] coordinates. Control points for rational trimming
/// curves require [u], [v], and [w] (weight) coordinates.
class ParameterSpaceVertex {
  /// The point in the parameter space of a curve or the first coordinate in
  /// the parameter space of a surface.
  final double u;

  /// The second coordinate in the parameter space of a surface.
  final double v;

  /// The weight required for rational trimming curves.
  ///
  /// If you do not specify a value for `w`, it defaults to `1.0`.
  final double w;

  // TODO: make v and w  optional positional arguments once Dart allows both
  // optional named and optional positional arguments in the same argument list.

  /// Instantiates a new [ParameterSpaceVertex].
  ParameterSpaceVertex(this.u, [this.v, this.w]);
}

/// Specifies a texture vertex and its coordinates.
///
/// A 1D texture requires only the [u] texture coordinate, a 2D texture requires
/// both [u] and [v] texture coordinates, and a 3D texture requires [u], [v] and
/// [w] texture coordinates.
class TextureVertex {
  /// The texture vertex coordinate in the horizontal direction of the texture.
  final double u;

  /// The texture vertex coordinate in the vertical direction of the texture.
  ///
  /// Only used for 2D and 3D textures.
  final double v;

  /// The texture vertex coordinate in the depth direction of the texture.
  ///
  /// Only used for 3D textures.
  final double w;

  /// Instantiates a new [TextureVertex].
  TextureVertex(this.u, [this.v, this.w]);
}

/// Specifies a normal vector with components [i], [j], and [k].
///
/// Vertex normals affect the smooth-shading and rendering of geometry. For
/// polygons, vertex normals are used in place of the actual facet normals. For
/// surfaces, vertex normals are interpolated over the entire surface and
/// replace the actual analytic surface normal.
///
/// When vertex normals are present, they supersede smoothing groups.
class VertexNormal {
  /// The first component of the normal vector.
  final double i;

  /// The second component of the normal vector.
  final double j;

  /// The third component of the normal vector.
  final double k;

  /// Instantiates a new [VertexNormal].
  VertexNormal(this.i, this.j, this.k);
}

abstract class Element {
  Iterable<String> get groups;

  int get smoothingGroup;

  String get objectName;
}

/// Specifies point elements by their vertices.
///
/// You can specify multiple points with this statement. Although points cannot
/// be shaded or rendered, they are used by other Advanced Visualizer programs.
class Points implements Element {
  /// References to the [GeometricVertex]s that define these [Points].
  final Iterable<GeometricVertexReference> vertexRefs;

  final int lineNumber;

  /// Creates a new [Points] instance.
  Points(this.vertexRefs, {this.lineNumber});

  String toSource() => vertexRefs
      .map((n) => n.referenceNumber.toString())
      .fold('p', (res, s) => '$res $s');
}

/// Specifies a line element by its [VertexPairs].
class Line implements Element {
  /// The [VertexPair]s that define this [Line].
  final Iterable<VertexPair> vertexPairs;

  final int lineNumber;

  Line(this.vertexPairs, {this.lineNumber});

  String toSource() =>
      vertexPairs.map((n) => n.toSource()).fold('l', (res, s) => '$res $s');
}

/// A pair of reference numbers for a [GeometricVertex] and a
/// [TextureVertex].
class VertexPair {
  /// The reference to this [VertexPair]'s [GeometricVertex].
  final GeometricVertexReference geometricVertexRef;

  /// The reference to this [VertexPair]'s [TextureVertex].
  ///
  /// Is `null` for geometric elements that are not textured.
  final TextureVertexReference textureVertexRef;

  /// Instantiates a new [VertexPair].
  VertexPair(this.geometricVertexRef, [this.textureVertexRef]);

  String toSource() {
    if (textureVertexRef != null) {
      final v = geometricVertexRef.referenceNumber;
      final vt = textureVertexRef.referenceNumber;

      return '$v/$vt';
    } else {
      return geometricVertexRef.referenceNumber.toString();
    }
  }
}

/// Specifies a face element by its [VertexTriplet]s.
///
/// Face elements use surface normals to indicate their orientation. If vertices
/// are ordered counterclockwise around the face, both the face and the normal
/// will point toward the viewer. If the vertex ordering is clockwise, both will
/// point away from the viewer. If the [vertexTriplets] include references to
/// [VertexNormal]s, then they should point in the general direction
/// of the surface normal, otherwise unpredictable results may occur.
///
/// If a face has a texture map assigned to it but the [vertexTriplets] do not
/// includes references to [TextureVertex]s, then the texture map should be
/// ignored when the element is rendered.
class Face implements Element {
  /// The [VertexTriplet]s that define this [Face].
  final Iterable<VertexTriplet> vertexTriplets;

  final int lineNumber;

  /// Instantiates a new [Face].
  Face(this.vertexTriplets, {this.lineNumber});

  String toSource() =>
      vertexTriplets.map((n) => n.toSource()).fold('f', (res, s) => '$res $s');
}

/// A triplet of reference numbers for a [GeometricVertex], a [TextureVertex]
/// and a [VertexNormal].
class VertexTriplet {
  /// The reference to this [VertexTriplet]'s [GeometricVertex].
  final GeometricVertexReference geometricVertexRef;

  /// The reference to this [VertexTriplet]'s [TextureVertex].
  ///
  /// Is `null` for geometric elements that are not textured.
  final TextureVertexReference textureVertexRef;

  /// The reference to this [VertexTriplet]'s [VertexNormal].
  ///
  /// If set to `null` then an implementation may use computed face normals or
  /// smooth normals. If not `null` then the [VertexNormal] should be used.
  final VertexNormalReference vertexNormalRef;

  /// Instantiates a new [VertexTriplet].
  VertexTriplet(this.geometricVertexRef,
      [this.textureVertexRef, this.vertexNormalRef]);

  String toSource() {
    if (vertexNormalRef != null) {
      final v = geometricVertexRef.referenceNumber;
      final vt = textureVertexRef.referenceNumber;
      final vn = vertexNormalRef.referenceNumber;

      return '$v/$vt/$vn';
    } else {
      return geometricVertexRef.referenceNumber.toString();
    }
  }
}

/// Enumerates the different free-form geometry types supported by the OBJ
/// specification.
enum FreeFormType { basisMatrix, bezier, bSpline, cardinal, taylor }

/// Defines free-form curve or surfaces elements.
abstract class FreeFormElement extends Element {
  /// Encapsulates the active free-form attribute state for this
  /// [FreeFormElement].
  FreeFormAttributeState get attributes;

  int get mergingGroup;
}

/// Encapsulates the active free-form attribute state for a [FreeFormElement].
class FreeFormAttributeState {
  /// The active curve or surface type.
  final FreeFormType type;

  /// Whether or not the free-form geometry is rational.
  final bool isRational;

  /// The polynomial degree in the `u` direction.
  ///
  /// Is required only for surfaces. For a [type] of Bezier, B-spline, Taylor,
  /// and basis matrix, there is no default; a value must be supplied. For
  /// Cardinal, the degree is always `3`. If some other value is given for
  /// Cardinal, it will be ignored.
  final int degreeU;

  /// The polynomial degree in the `v` direction.
  ///
  /// Is required only for surfaces. For a [type] of Bezier, B-spline, Taylor,
  /// and basis matrix, there is no default; a value must be supplied. For
  /// Cardinal, the degree is always `3`. If some other value is given for
  /// Cardinal, it will be ignored.
  final int degreeV;

  /// The step size in the `u` direction for for curves and surfaces that use a
  /// basis matrix.
  ///
  /// When a curve or surface is being evaluated and a transition from one
  /// segment or patch to the next occurs, the set of control points used is
  /// incremented by the step size. The appropriate step size depends on the
  /// representation type, which is expressed through the basis matrix, and on
  /// the degree. That is, suppose we are given a curve with k control points:
  /// `(v_1 , ..., v_k)`. If the curve is of degree `n`, then `n + 1` control
  /// points are needed for each polynomial segment. If the step size is given
  /// as `s`, then the `i`th polynomial segment, where `i = 0` is the first
  /// segment, will use the control points:
  /// `(v_{i * s + 1}, ..., v_{i * s + n + 1})`.
  ///
  /// For example, for Bezier curves, `s = n`.
  ///
  /// For surfaces, the above description applies independently to each
  /// parametric direction (see also [stepV]).
  ///
  /// Required only for curves and surfaces that use a basis matrix. There is
  /// no default, a value must be supplied.
  final int stepU;

  /// The step size in the `v` direction for for curves and surfaces that use a
  /// basis matrix.
  ///
  /// Required only for surfaces that use a basis matrix. There is no default, a
  /// value must be supplied. See [stepU] for details.
  final int stepV;

  /// The basis matrix used for basis matrix curves and surfaces in the `u`
  /// direction.
  ///
  /// If `n` is the degree in the given `u` or `v` direction, the matrix `(i,j)`
  /// should be of size `(n + 1) x (n + 1)`. There is no default, a value must
  /// be supplied.
  final Matrix basisMatrixU;

  /// The basis matrix used for basis matrix curves and surfaces in the `v`
  /// direction.
  ///
  /// If `n` is the degree in the given `u` or `v` direction, the matrix `(i,j)`
  /// should be of size `(n + 1) x (n + 1)`. There is no default, a value must
  /// be supplied.
  final Matrix basisMatrixV;

  /// Instantiates a new [FreeFormAttributeState] instance.
  FreeFormAttributeState(this.type, this.isRational, this.degreeU, this.degreeV,
      this.stepU, this.stepV, this.basisMatrixU, this.basisMatrixV);
}

/// Defines a curve in space.
///
/// The curve is evaluated within the global parameter range from [start] to
/// [end].
class Curve implements FreeFormElement {
  /// Starting parameter value for the curve.
  final double start;

  /// The ending parameter value for the curve.
  final double end;

  /// References to the [GeometricVertex]s that act as the control points for
  /// this [Curve].
  ///
  /// You can specify multiple control points. A minimum of two control points
  /// are required for a curve.
  ///
  /// For a non-rational curve, the control points must be 3D. For a rational
  /// curve, the control points are 3D or 4D. The fourth coordinate (weight)
  /// defaults to 1.0 if omitted.
  final Iterable<GeometricVertexReference> controlPointRefs;

  /// Specifies global parameter values (or knot values for B-spline curves).
  ///
  /// You can specify multiple values. A minimum of two parameter values are
  /// required. Parameter values must increase monotonically. The type of
  /// curve and the degree dictate the number of values required.
  final Iterable<double> parameterValues;

  final FreeFormAttributeState attributes;

  /// References to the [ParameterSpaceVertex]s that act as special points for
  /// this [Curve].
  ///
  /// Special points must be included in any linear approximation of the curve.
  /// For space curves, this means that the point corresponding to the given
  /// curve parameter must be included as one of the vertices in an
  /// approximation consisting of a sequence of line segments.
  ///
  /// The [ParameterSpaceVertex]s must be 1D.
  final Iterable<ParameterSpaceVertexReference> specialPointRefs;

  final int lineNumber;

  /// Instantiates a new [Curve].
  Curve(this.start, this.end, this.controlPointRefs, this.parameterValues,
      this.attributes,
      {this.specialPointRefs, this.lineNumber});

  String toSource() {
    var result = controlPointRefs
        .map((r) => r.referenceNumber.toString())
        .fold('curv $start $end', (res, r) => '$res $r');

    result += parameterValues
        .map((v) => v.toString())
        .fold('\nparm u', (res, s) => '$res $s');

    if (specialPointRefs != null && specialPointRefs.isNotEmpty) {
      result += specialPointRefs
          .map((r) => r.referenceNumber.toString())
          .fold('\nsp', (res, s) => '$res $s');
    }

    return result + '\nend';
  }
}

/// Specifies a 2D curve on a surface.
///
/// A 2D curve is used as an outer or inner trimming curve for a surface (see
/// [Surface.regions]), as a special curve for a surface (see
/// [Surface.specialCurves]), or for connectivity.
class Curve2D implements FreeFormElement {
  /// References to the [ParameterSpaceVertex]s that act as the control points
  /// for this [Curve2D].
  ///
  /// You can specify multiple control points. A minimum of two control points
  /// are required for a curve.
  ///
  /// The control points are parameter space vertices because the curve must lie
  /// in the parameter space of some surface. For a non-rational curve, the
  /// control vertices can be 2D. For a rational curve, the control vertices can
  /// be 2D or 3D. The third coordinate (weight) defaults to 1.0 if omitted.
  final Iterable<ParameterSpaceVertexReference> controlPointRefs;

  /// Specifies global parameter values (or knot values for B-spline curves).
  ///
  /// You can specify multiple values. A minimum of two parameter values are
  /// required. Parameter values must increase monotonically. The type of
  /// curve and the degree dictate the number of values required.
  final Iterable<double> parameterValues;

  final FreeFormAttributeState attributes;

  /// Reference to the [ParameterSpaceVertex]s that act as special points for
  /// this [Curve2D].
  ///
  /// Special points must be included in any linear approximation of the curve.
  /// For space curves, this means that the point corresponding to the given
  /// curve parameter must be included as one of the vertices in an
  /// approximation consisting of a sequence of line segments.
  ///
  /// The [ParameterSpaceVertex]s must be 1D.
  final Iterable<ParameterSpaceVertexReference> specialPointRefs;

  final int lineNumber;

  /// Instantiates a new [Curve2D].
  Curve2D(this.controlPointRefs, this.attributes, this.parameterValues,
      {this.specialPointRefs, this.lineNumber});

  String toSource() {
    var result = controlPointRefs
        .map((r) => r.referenceNumber.toString())
        .fold('curv2', (res, r) => '$res $r');

    result += parameterValues
        .map((v) => v.toString())
        .fold('\nparm u', (res, s) => '$res $s');

    if (specialPointRefs != null && specialPointRefs.isNotEmpty) {
      result += specialPointRefs
          .map((r) => r.referenceNumber.toString())
          .fold('\nsp', (res, s) => '$res $s');
    }

    return result + '\nend';
  }
}

/// Defines a surface.
///
/// The surface is evaluated within the global parameter range from [startU] to
/// [endU] in the `u` direction and [startV] to [endV] in the `v` direction.
class Surface implements FreeFormElement {
  /// The starting parameter value for the surface in the `u` direction.
  final double startU;

  /// The ending parameter value for the surface in the `u` direction.
  final double endU;

  /// The starting parameter value for the surface in the `v` direction.
  final double startV;

  /// The ending parameter value for the surface in the `v` direction.
  final double endV;

  /// The [VertexTriplet]s that define the control points for this surface.
  ///
  /// For a non-rational surface, the control vertices are 3D. For a rational
  /// surface the control vertices can be 3D or 4D. The fourth coordinate
  /// (weight) defaults to 1.0 if omitted.
  ///
  /// For more information on the ordering of control points for surfaces, refer
  /// to the section on surfaces and control points in the "mathematics of
  /// free-form curves/surfaces" section at the end of the OBJ specification.
  final Iterable<VertexTriplet> controlPointTriplets;

  /// Specifies global parameter values (or knot values for B-spline surfaces)
  /// in the `u` direction.
  ///
  /// You can specify multiple values. A minimum of two parameter values are
  /// required. Parameter values must increase monotonically. The type of
  /// surface and the degree dictate the number of values required.
  final Iterable<double> parameterValuesU;

  /// Specifies global parameter values (or knot values for B-spline surfaces)
  /// in the `v` direction.
  ///
  /// You can specify multiple values. A minimum of two parameter values are
  /// required. Parameter values must increase monotonically. The type of
  /// surface and the degree dictate the number of values required.
  final Iterable<double> parameterValuesV;

  /// The trimming regions defined on this [Surface].
  final Iterable<SurfaceRegion> regions;

  /// References to the [ParameterSpaceVertex]s that act as special points for
  /// this [Surface].
  ///
  /// Special points must be included in any linear approximation of the
  /// surface. For surfaces, this means that the point corresponding to the
  /// given surface parameters must be included as a triangle vertex in the
  /// triangulation of the surface.
  ///
  /// The [ParameterSpaceVertex]s must be 2D.
  final Iterable<ParameterSpaceVertexReference> specialPointRefs;

  /// The special curves for this [Surface].
  ///
  /// A single special curve is build from a sequence of [Curve2DInstance]s
  /// which lie on this [Surface].
  ///
  /// Each special curve must be included in any triangulation of the surface.
  /// This means that the line formed by approximating the special curve with a
  /// sequence of straight line segments must actually appear as a sequence of
  /// triangle edges in the final triangulation.
  final Iterable<Iterable<Curve2DInstance>> specialCurves;

  final FreeFormAttributeState attributes;

  final int lineNumber;

  /// Instantiates a new [Surface].
  Surface(
      this.startU,
      this.endU,
      this.startV,
      this.endV,
      this.controlPointTriplets,
      this.parameterValuesU,
      this.parameterValuesV,
      this.attributes,
      {this.regions,
      this.specialPointRefs,
      this.specialCurves,
      this.lineNumber});

  String toSource() {
    var result = controlPointTriplets
        .map((r) => r.toString())
        .fold('surf $startU $endU $startV $endV', (res, r) => '$res $r');

    result += parameterValuesU
        .map((v) => v.toString())
        .fold('\nparm u', (res, s) => '$res $s');

    result += parameterValuesV
        .map((v) => v.toString())
        .fold('\nparm v', (res, s) => '$res $s');

    if (regions != null) {
      regions.forEach((region) {
        if (region.trimmingLoop != null) {
          result += region.trimmingLoop
              .map((c) => c.toSource())
              .fold('\ntrim', (res, s) => '$res $s');
        }

        region.holeLoops.forEach((holeLoop) {
          result += holeLoop
              .map((c) => c.toSource())
              .fold('\nhole', (res, s) => '$res $s');
        });
      });
    }

    if (specialCurves != null) {
      specialCurves.forEach((specialCurve) {
        result += specialCurve
            .map((c) => c.toSource())
            .fold('\nscrv', (res, s) => '$res $s');
      });
    }

    if (specialPointRefs != null && specialPointRefs.isNotEmpty) {
      result += specialPointRefs
          .map((r) => r.referenceNumber.toString())
          .fold('\nsp', (res, s) => '$res $s');
    }

    return result + '\nend';
  }
}

/// A region of a [Surface] defined by a [trimmingLoop] and 0 or more
/// [holeLoops].
class SurfaceRegion {
  /// A sequence of [Curve2DInstance]s that form the outer trimming loop of
  /// this [SurfaceRegion].
  ///
  /// The individual curves must lie end-to-end to form a closed loop which does
  /// not intersect itself and which lies within the parameter range specified
  /// for the [Surface] to which this [SurfaceRegion] belongs. The
  /// loop as a whole may be oriented in either direction (clockwise or
  /// counterclockwise).
  ///
  /// If `null` then the outer trimming loop is defined by the parameter range
  /// of the surface to which this [SurfaceRegion] belongs.
  final Iterable<Curve2DInstance> trimmingLoop;

  /// A sequence of Curve2D loops that form the inner trimming loops of the
  /// [SurfaceRegion].
  ///
  /// For each hole loop, the individual curves must lie end-to-end to form a
  /// closed loop which does not intersect itself and which lies within the
  /// parameter range specified for the [Surface] to which this
  /// [SurfaceRegion] belongs. The loop as a whole may be oriented in either
  /// direction (clockwise or counterclockwise).
  final Iterable<Iterable<Curve2DInstance>> holeLoops;

  /// Instantiates a new [SurfaceRegion].
  SurfaceRegion(this.trimmingLoop, this.holeLoops);
}

/// Instance of a [Curve2D] defined on the parameter range from [start] to
/// [end].
class Curve2DInstance {
  /// The starting parameter value for this [Curve2DInstance].
  final double start;

  /// The ending parameter value for this [Curve2DInstance].
  final double end;

  /// A reference to the [Curve2D] that defines this [Curve2DInstance].
  final Curve2DReference curve2DRef;

  /// Instantiates a new [Curve2DInstance].
  Curve2DInstance(this.start, this.end, this.curve2DRef);

  String toSource() => '$start $end ${curve2DRef.referenceNumber}';
}

/// Connects two surfaces along trimming curves.
///
/// The two curves and their starting and ending parameters should all map to
/// the same curve and starting and ending points in object space.
///
/// Connectivity between surfaces in different merging groups is ignored. Also,
/// although connectivity which crosses points of C1discontinuity in the
/// trimming curves is legal, it is not recommended. Instead, use two
/// [SurfaceConnection]s which meet at the point of discontinuity.
class SurfaceConnection implements Definition {
  /// A reference to one of the two [Surface]s connected by this
  /// [SurfaceConnection].
  ///
  /// See also [surface2].
  final SurfaceReference surface1Ref;

  /// The trimming curve for [surface1].
  final Curve2DInstance trimmingCurve1;

  /// A reference to one of the two [Surface]s connected by this
  /// [SurfaceConnection].
  ///
  /// See also [surface1].
  final SurfaceReference surface2Ref;

  /// The trimming curve for [surface2].
  final Curve2DInstance trimmingCurve2;

  final int lineNumber;

  SurfaceConnection(this.surface1Ref, this.trimmingCurve1, this.surface2Ref,
      this.trimmingCurve2,
      {this.lineNumber});

  String toSource() =>
      'con ${surface1Ref.referenceNumber} ${trimmingCurve1.toSource()} '
      '${surface2Ref.referenceNumber} ${trimmingCurve2.toSource()}';
}

class GeometryGroup {
  final Iterable<String> names;

  final bool isDefault;

  final Points points;

  final Lines lines;

  final Faces faces;

  final Curves curves;

  final Surfaces surfaces;
}

class Obj {
  final GeometricVertices geometricVertices;

  final VertexNormals vertexNormals;

  final TextureVertices textureVertices;

  final ParameterSpaceVertices parameterSpaceVertices;

  final PointsElements pointElements;

  final LineElements lineElements;

  final FaceElements faceElements;

  final CurveElements curveElements;

  final Curve2DElements curve2DElements;

  final SurfaceElements surfaceElements;

  final SurfaceConnections surfaceConnections;

  final Iterable<GeometryGroup> geometryGroups;
}

/// A reference to a [GeometricVertex].
class GeometricVertexReference {
  /// The reference number that identifies the [GeometricVertex] in an [Obj].
  ///
  /// Note that reference numbers are `1` indexed rather than `0` indexed,
  /// meaning that reference number `1` identifies the first [GeometricVertex]
  /// defined in the `.obj` file.
  final int referenceNumber;

  /// Instantiates a new [GeometricVertexReference].
  GeometricVertexReference(this.referenceNumber);

  /// Resolves the [GeometricVertex] identified by this reference in the [obj].
  ///
  /// Returns `null` if no [GeometricVertex] with the [referenceNumber] was
  /// found in the [obj].
  GeometricVertex resolve(Obj obj) => obj.geometricVertices[referenceNumber];
}

/// A reference to a [VertexNormal].
class VertexNormalReference {
  /// The reference number that identifies the [VertexNormal] in an [Obj].
  ///
  /// Note that reference numbers are `1` indexed rather than `0` indexed,
  /// meaning that reference number `1` identifies the first [VertexNormal]
  /// defined in the `.obj` file.
  final int referenceNumber;

  /// Instantiates a new [VertexNormalReference].
  VertexNormalReference(this.referenceNumber);

  /// Resolves the [VertexNormal] identified by this reference in the [obj].
  ///
  /// Returns `null` if no [VertexNormal] with the [referenceNumber] was found
  /// in the [obj].
  VertexNormal resolve(Obj obj) => obj.vertexNormals[referenceNumber];
}

/// A reference to a [TextureVertex].
class TextureVertexReference {
  /// The reference number that identifies the [TextureVertex] in an [Obj].
  ///
  /// Note that reference numbers are `1` indexed rather than `0` indexed,
  /// meaning that reference number `1` identifies the first [TextureVertex]
  /// defined in the `.obj` file.
  final int referenceNumber;

  /// Instantiates a new [TextureVertexReference].
  TextureVertexReference(this.referenceNumber);

  /// Resolves the [TextureVertex] identified by this reference in the [obj].
  ///
  /// Returns `null` if no [TextureVertex] with the [referenceNumber] was found
  /// in the [obj].
  TextureVertex resolve(Obj obj) => obj.textureVertices[referenceNumber];
}

/// A reference to a [ParameterSpaceVertex].
class ParameterSpaceVertexReference {
  /// The reference number that identifies the [ParameterSpaceVertex] in an
  /// [Obj].
  ///
  /// Note that reference numbers are `1` indexed rather than `0` indexed,
  /// meaning that reference number `1` identifies the first
  /// [ParameterSpaceVertex] defined in the `.obj` file.
  final int referenceNumber;

  /// Instantiates a new [ParameterSpaceVertexReference].
  ParameterSpaceVertexReference(this.referenceNumber);

  /// Resolves the [ParameterSpaceVertex] identified by this reference in the
  /// [obj].
  ///
  /// Returns `null` if no [ParameterSpaceVertex] with the [referenceNumber] was
  /// found in the [obj].
  ParameterSpaceVertex resolve(Obj obj) =>
      obj.parameterSpaceVertices[referenceNumber];
}

/// A reference to a [Curve2D].
class Curve2DReference {
  /// The reference number that identifies the [Curve2D] in an [Obj].
  ///
  /// Note that reference numbers are `1` indexed rather than `0` indexed,
  /// meaning that reference number `1` identifies the first [Curve2D] defined
  /// in the `.obj` file.
  final int referenceNumber;

  /// Instantiates a new [Curve2DReference].
  Curve2DReference(this.referenceNumber);

  /// Resolves the [Curve2D] identified by this reference in the [obj].
  ///
  /// Returns `null` if no [Curve2D] with the [referenceNumber] was found in the
  /// [obj].
  Curve2D resolve(Obj obj) => obj.curve2DElements[referenceNumber];
}

/// A reference to a [Surface].
class SurfaceReference {
  /// The reference number that identifies the [Surface] in an [Obj].
  ///
  /// Note that reference numbers are `1` indexed rather than `0` indexed,
  /// meaning that reference number `1` identifies the first [Curve2D] defined
  /// in the `.obj` file.
  final int referenceNumber;

  /// Instantiates a new [SurfaceReference].
  SurfaceReference(this.referenceNumber);

  /// Resolves the [Surface] identified by this reference in the [obj].
  ///
  /// Returns `null` if no [Surface] with the [referenceNumber] was found in the
  /// [obj].
  Surface resolve(Obj obj) => obj.surfaceElements[referenceNumber];
}

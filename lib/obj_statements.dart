library obj_statements;

/// Enumerates the parameter directions.
enum ParameterDirection { u, v }

/// Enumerates the different free-form curve and surface types supported by the
/// OBJ specification.
enum CSType { basisMatrix, bezier, bSpline, cardinal, taylor }

/// Enumerates the available approximation techniques for free-form curve
/// geometry.
enum CTech {
  constantParametricSubdivision,
  constantSpatialSubdivision,
  curvatureDependentSubdivision
}

/// Enumerates the available approximation techniques for free-form surface
/// geometry.
enum STech {
  constantParametricSubdivisionA,
  constantParametricSubdivisionB,
  constantSpatialSubdivision,
  curvatureDependentSubdivision
}

/// Defines the interface for `obj` statements.
abstract class ObjStatement {
  /// The line number at which this [ObjStatement] occurred in its source file.
  ///
  /// May be `null` for [ObjStatement]s that did not originate from a source
  /// file.
  int get lineNumber;

  /// Accepts a visit from the [visitor].
  void acceptVisit(ObjStatementVisitor visitor);

  /// A valid source code representation of this [ObjStatement].
  String toSource();
}

/// Defines the interface for [ObjStatement] visitors.
abstract class ObjStatementVisitor {
  void visitVStatement(VStatement statement);

  void visitVtStatement(VtStatement statement);

  void visitVnStatement(VnStatement statement);

  void visitVpStatement(VpStatement statement);

  void visitCstypeStatement(CstypeStatement statement);

  void visitDegStatement(DegStatement statement);

  void visitBmatStatement(BmatStatement statement);

  void visitStepStatement(StepStatement statement);

  void visitPStatement(PStatement statement);

  void visitLStatement(LStatement statement);

  void visitFStatement(FStatement statement);

  void visitCurvStatement(CurvStatement statement);

  void visitCurv2Statement(Curv2Statement statement);

  void visitSurfStatement(SurfStatement statement);

  void visitParmStatement(ParmStatement statement);

  void visitTrimStatement(TrimStatement statement);

  void visitHoleStatement(HoleStatement statement);

  void visitScrvStatement(ScrvStatement statement);

  void visitSpStatement(SpStatement statement);

  void visitEndStatement(EndStatement statement);

  void visitConStatement(ConStatement statement);

  void visitGStatement(GStatement statement);

  void visitSStatement(SStatement statement);

  void visitMgStatement(MgStatement statement);

  void visitOStatement(OStatement statement);

  void visitBevelStatement(BevelStatement statement);

  void visitCInterpStatement(CInterpStatement statement);

  void visitDInterpStatement(DInterpStatement statement);

  void visitLodStatement(LodStatement statement);

  void visitMaplibStatement(MaplibStatement statement);

  void visitUsemapStatement(UsemapStatement statement);

  void visitUsemtlStatement(UsemtlStatement statement);

  void visitMtllibStatement(MtllibStatement statement);

  void visitShadowObjStatement(ShadowObjStatement statement);

  void visitTraceObjStatement(TraceObjStatement statement);

  void visitCtechStatement(CtechStatement statement);

  void visitStechStatement(StechStatement statement);
}

/// Specifies a geometric vertex and its [x], [y] and [z] coordinates.
///
/// Rational curves and surfaces require a fourth homogeneous coordinate [w],
/// also called the weight.
class VStatement implements ObjStatement {
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

  final int lineNumber;

  // TODO: make w an optional positional argument once Dart allows both optional
  // named and optional positional arguments in the same argument list.

  /// Instantiates a new [VStatement].
  VStatement(this.x, this.y, this.z, this.w, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVStatement(this);
  }

  String toSource() {
    if (w != null) {
      return 'v $x $y $z $w';
    } else {
      return 'v $x $y $z';
    }
  }
}

/// Specifies a texture vertex and its coordinates.
///
/// A 1D texture requires only the [u] texture coordinate, a 2D texture requires
/// both [u] and [v] texture coordinates, and a 3D texture requires [u], [v] and
/// [w] texture coordinates.
class VtStatement implements ObjStatement {
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

  final int lineNumber;

  /// Instantiates a new [VtStatement].
  VtStatement(this.u, this.v, this.w, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVtStatement(this);
  }

  String toSource() {
    if (v != null) {
      if (w != null) {
        return 'vt $u $v $w';
      } else {
        return 'vt $u $v';
      }
    } else {
      return 'vt $u';
    }
  }
}

/// Specifies a normal vector with components [i], [j], and [k].
///
/// Vertex normals affect the smooth-shading and rendering of geometry. For
/// polygons, vertex normals are used in place of the actual facet normals. For
/// surfaces, vertex normals are interpolated over the entire surface and
/// replace the actual analytic surface normal.
///
/// When vertex normals are present, they supersede smoothing groups.
class VnStatement implements ObjStatement {
  /// The first component of the normal vector.
  final double i;

  /// The second component of the normal vector.
  final double j;

  /// The third component of the normal vector.
  final double k;

  final int lineNumber;

  /// Instantiates a new [VertexNormal].
  VnStatement(this.i, this.j, this.k, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVnStatement(this);
  }

  String toSource() => 'vn $i $j $k';
}

/// Specifies a point in the parameter space of a curve or surface.
///
/// The usage determines how many coordinates are required. Special points for
/// curves require a 1D control point ([u] only) in the parameter space of the
/// curve. Special points for surfaces require a 2D point ([u] and [v]) in the
/// parameter space of the surface. Control points for non-rational trimming
/// curves require [u] and [v] coordinates. Control points for rational trimming
/// curves require [u], [v], and [w] (weight) coordinates.
class VpStatement implements ObjStatement {
  /// The point in the parameter space of a curve or the first coordinate in
  /// the parameter space of a surface.
  final double u;

  /// The second coordinate in the parameter space of a surface.
  final double v;

  /// The weight required for rational trimming curves.
  ///
  /// If you do not specify a value for `w`, it defaults to `1.0`.
  final double w;

  final int lineNumber;

  // TODO: make v and w  optional positional arguments once Dart allows both
  // optional named and optional positional arguments in the same argument list.

  /// Instantiates a new [ParameterSpaceVertex].
  VpStatement(this.u, this.v, this.w, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitVpStatement(this);
  }

  String toSource() => 'vp $u $v $w';
}

const _csTypeStringMapping = const {
  CSType.basisMatrix: 'bmatrix',
  CSType.bezier: 'bezier',
  CSType.bSpline: 'bspline',
  CSType.cardinal: 'cardinal',
  CSType.taylor: 'taylor'
};

/// State setting statement that specifies the type and rationality of any
/// curves and surfaces superseding it.
class CstypeStatement implements ObjStatement {
  /// The curve or surface type set by this [CstypeStatement].
  final CSType type;

  /// Whether or not superseding curves and statements are rational or not.
  final bool isRational;

  final int lineNumber;

  /// Instantiates a new [CstypeStatement].
  CstypeStatement(this.type, {this.isRational, this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCstypeStatement(this);
  }

  String toSource() {
    final typeString = _csTypeStringMapping[type];

    if (isRational) {
      return 'cstype rat $typeString';
    } else {
      return 'cstype $typeString';
    }
  }
}

/// State settings statement that specifies the polynomial degrees of the curves
/// and surfaces superseding it.
class DegStatement implements ObjStatement {
  /// The polynomial degree in the `u` direction.
  ///
  /// Is required for both curves and surfaces. For a [type] of `bezier`,
  /// `bSpline`, `taylor` or `basisMatrix`, there is no default; a value must be
  /// supplied. For a [type] of `cardinal`, the degree is always `3`. If some
  /// other value is given for `cardinal`, then it will be ignored.
  final int degreeU;

  /// The polynomial degree in the `v` direction.
  ///
  /// Is required only for surfaces. For a [type] of `bezier`, `bSpline`,
  /// `taylor` or `basisMatrix`, there is no default; a value must be supplied.
  /// For a [type] of `cardinal`, the degree is always `3`. If some other value
  /// is given for `cardinal`, then it will be ignored.
  final int degreeV;

  final int lineNumber;

  // TODO: make degreeV an optional positional argument once Dart allows both
  // optional named and optional positional arguments in the same argument list.

  /// Instantiates a new [DegStatement].
  DegStatement(this.degreeU, this.degreeV, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitDegStatement(this);
  }

  String toSource() {
    if (degreeV != null) {
      return 'deg $degreeU $degreeV';
    } else {
      return 'deg $degreeU';
    }
  }
}

/// State setting statements that specifies a basis matrix for curves and
/// surfaces superseding it.
///
/// Only required when the most recent [CstypeStatement] has set the type to
/// [CSType.basisMatrix].
///
/// For surfaces, this statements needs to be occur twice, once for each
/// [direction].
class BmatStatement implements ObjStatement {
  /// The direction in which the basis matrix is applied.
  ///
  /// Curves only need a basis matrix in the [ParameterDirection.u] direction.
  /// Surfaces also require a basis matrix in the [ParameterDirection.v]
  /// direction. Two separate [BmatStatement]s are required to specify the basis
  /// matrices for both directions.
  final ParameterDirection direction;

  /// The matrix values in row major order.
  ///
  /// If `n` is the degree in the given `u` or `v` direction (as set with a
  /// [DegStatement]), then the matrix `(i,j)` should be of size
  /// `(n + 1) x (n + 1)`.
  final Iterable<double> values;

  final int lineNumber;

  /// Instantiates a new [BmatStatement].
  BmatStatement(this.direction, this.values, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitBmatStatement(this);
  }

  String toSource() {
    final valuesString =
        values.map((v) => v.toString()).reduce((res, v) => '$res $v');

    if (direction == ParameterDirection.v) {
      return 'bmat v $valuesString';
    } else {
      return 'bmat u $valuesString';
    }
  }
}

/// State setting statement that sets the step size for the basis matrix curves
/// and surfaces superseding it.
///
/// When a curve or surface is being evaluated and a transition from one segment
/// or patch to the next occurs, the set of control points used is incremented
/// by the step size. The appropriate step size depends on the representation
/// type, which is expressed through the basis matrix (as set with a
/// [BmatStatement]), and on the degree (as set with a [DegStatement]). That is,
/// suppose we are given a curve with `k` control points: `(v_1 , ..., v_k)`. If
/// the curve is of degree `n`, then `n + 1` control points are needed for each
/// polynomial segment. If the step size is given as `s`, then the `i`th
/// polynomial segment, where `i = 0` is the first segment, will use the control
/// points: `(v_{i * s + 1}, ..., v_{i * s + n + 1})`.
///
/// For example, for Bezier curves, `s = n`.
///
/// For surfaces, the above description applies independently to each
/// parametric direction (see also [stepV]).
///
/// Required only for curves and surfaces that use a basis matrix. There is
/// no default, a value must be supplied.
class StepStatement implements ObjStatement {
  /// The step size in the `u` direction.
  final int stepU;

  /// The step size in the `v` direction.
  final int stepV;

  final int lineNumber;

  // TODO: make stepV an optional positional argument once Dart allows both
  // optional named and optional positional arguments in the same argument list.

  /// Instantiates a new [StepStatement].
  StepStatement(this.stepU, this.stepV, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitStepStatement(this);
  }

  String toSource() {
    if (stepV != null) {
      return 'step $stepU $stepV';
    } else {
      return 'step $stepU';
    }
  }
}

/// Specifies point elements by referencing their vertices.
///
/// You can specify multiple points with this statement.
class PStatement implements ObjStatement {
  /// The reference numbers of the geometric vertices that define the points.
  ///
  /// Should contain at least 1 reference number.
  final Iterable<int> vNums;

  final int lineNumber;

  /// Instantiates a new [PStatement].
  PStatement(this.vNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitPStatement(this);
  }

  String toSource() =>
      vNums.map((n) => n.toString()).fold('p', (res, s) => '$res $s');
}

/// Specifies a line element by its [VertexNumPair]s.
class LStatement implements ObjStatement {
  /// The [VertexNumPair]s that define the line.
  ///
  /// Should contain at least 2 [VertexNumPair]s.
  final Iterable<VertexNumPair> vertexNumPairs;

  final int lineNumber;

  /// Instantiates a new [LStatement].
  LStatement(this.vertexNumPairs, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitLStatement(this);
  }

  String toSource() =>
      vertexNumPairs.map((n) => n.toSource()).fold('l', (res, s) => '$res $s');
}

/// A pair of numbers or which [vNum] is the reference number for a geometric
/// vertex and [vtNum] is the reference number of a texture vertex.
class VertexNumPair {
  /// A reference number for a geometric vertex.
  final int vNum;

  /// A reference number for a texture vertex.
  final int vtNum;

  /// Instantiates a new [VertexNumPair].
  VertexNumPair(this.vNum, this.vtNum);

  /// A source code representation of the number pair.
  String toSource() {
    if (vtNum != null) {
      return '$vNum/$vtNum';
    } else {
      return vNum.toString();
    }
  }
}

/// Specifies a face element by its [VertexNumTriple]s.
class FStatement implements ObjStatement {
  /// The [VertexNumTriple]s that define the face.
  ///
  /// Should contain at least 3 [VertexNumTriple]s.
  final Iterable<VertexNumTriple> vertexNumTriples;

  final int lineNumber;

  /// Instantiates a new [FStatement].
  FStatement(this.vertexNumTriples, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitFStatement(this);
  }

  String toSource() => vertexNumTriples
      .map((n) => n.toSource())
      .fold('l', (res, s) => '$res $s');
}

/// A triple of numbers or which [vNum] is the reference number for a geometric
/// vertex, [vtNum] is the reference number of a texture vertex, and [vnNum] is
/// the reference number of a vertex normal.
class VertexNumTriple {
  /// A reference number for a geometric vertex.
  final int vNum;

  /// A reference number for a texture vertex.
  final int vtNum;

  /// A reference number for a vertex normal.
  final int vnNum;

  /// Instantiates a new [VertexNumTriple].
  VertexNumTriple(this.vNum, this.vtNum, this.vnNum);

  /// A source code representation of the number pair.
  String toSource() {
    if (vnNum != null) {
      return '$vNum/$vtNum/$vnNum';
    } else {
      return vNum.toString();
    }
  }
}

/// Specifies a curve, its parameter range, and its control vertices.
class CurvStatement implements ObjStatement {
  /// The starting parameter value for the curve.
  final double start;

  /// The ending parameter value for the curve.
  final double end;

  /// The reference numbers of the geometric vertices that act as the control
  /// points for the curve.
  ///
  /// For a non-rational curve, the control points must be 3D. For a rational
  /// curve, the control points are 3D or 4D. The fourth coordinate (weight)
  /// defaults to 1.0 if omitted.
  ///
  /// A minimum of two control points are required.
  final Iterable<int> controlPointNums;

  final int lineNumber;

  /// Instantiates a new [CurvStatement].
  CurvStatement(this.start, this.end, this.controlPointNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCurvStatement(this);
  }

  String toSource() => controlPointNums
      .map((n) => n.toString())
      .fold('curv $start $end', (res, s) => '$res $s');
}

/// Specifies a 2D curve on a surface and its control points.
///
/// A 2D curve is used as an outer or inner trimming curve, as a special curve,
/// or for connectivity.
class Curv2Statement implements ObjStatement {
  /// The reference numbers of the parameter space vertices that act as the
  /// control points for the curve.
  ///
  /// A minimum of two control points are required.
  final Iterable<int> controlPointNums;

  final int lineNumber;

  /// Instantiates a new [Curv2Statement].
  Curv2Statement(this.controlPointNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCurv2Statement(this);
  }

  String toSource() => controlPointNums
      .map((n) => n.toString())
      .fold('curv2', (res, s) => '$res $s');
}

/// Instance of a 2D curve defined on the parameter range from [start] to [end].
class Curve2Instance {
  /// The starting parameter value for this [Curve2Instance].
  final double start;

  /// The ending parameter value for this [Curve2Instance].
  final double end;

  /// A reference to the 2D curve that defines this [Curve2Instance].
  final int curve2Num;

  /// Instantiates a new [Curve2Instance].
  Curve2Instance(this.start, this.end, this.curve2Num);

  String toSource() => '$start $end $curve2Num';
}

/// Specifies a surface, its parameter range, and its control vertices.
///
/// The surface is evaluated within the global parameter range from [startU] to
/// [endU] in the `u` direction and from [startV] to [endV] in the `v`
/// direction.
class SurfStatement implements ObjStatement {
  /// The starting parameter value for the curve in the `u` direction.
  final double startU;

  /// The ending parameter value for the curve in the `u` direction.
  final double endU;

  /// The starting parameter value for the curve in the `v` direction.
  final double startV;

  /// The ending parameter value for the curve in the `v` direction.
  final double endV;

  /// The [VertexNumTriple]s that act as the control points for the surface.
  ///
  /// For a non-rational surface, the control vertices are 3D.  For a rational
  /// surface the control vertices can be 3D or 4D.  The fourth coordinate
  /// (weight) defaults to 1.0 if omitted.
  ///
  /// For more information on the ordering of control points for surfaces, refer
  /// to the section on surfaces and control points in "mathematics of free-form
  /// curves/surfaces" at the end of the OBJ 3.0 specification.
  final Iterable<VertexNumTriple> controlPointTriples;

  final int lineNumber;

  /// Instantiates a new [SurfStatement].
  SurfStatement(
      this.startU, this.endU, this.startV, this.endV, this.controlPointTriples,
      {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitSurfStatement(this);
  }

  String toSource() => controlPointTriples
      .map((n) => n.toSource())
      .fold('surf $startU $endU $startV $endV', (res, s) => '$res $s');
}

/// Body statement for free-form geometry (curves and surfaces) that specifies
/// global parameter values.
///
/// For B-spline curves and surfaces, this specifies the knot vectors.
class ParmStatement implements ObjStatement {
  /// Specifies the [ParameterDirection] in which the [parameterValues] are
  /// applied.
  ///
  /// Curves only need parameter values in the [ParameterDirection.u] direction.
  /// Surfaces also require parameter values in the [ParameterDirection.v]
  /// direction. Two separate [ParmStatement]s are required to specify the
  /// parameter values for both directions.
  final ParameterDirection direction;

  /// The global parameter or knot values.
  ///
  /// You can specify multiple values. A minimum of two parameter values are
  /// required. Parameter values must increase monotonically. The type of
  /// surface and the degree dictate the number of values required.
  final Iterable<double> parameterValues;

  final int lineNumber;

  /// Instantiates a new [ParmStatement].
  ParmStatement(this.direction, this.parameterValues, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitParmStatement(this);
  }

  String toSource() {
    final parmString =
        parameterValues.map((n) => n.toString()).reduce((res, s) => '$res $s');

    if (direction == ParameterDirection.v) {
      return 'parm v $parmString';
    } else {
      return 'parm u $parmString';
    }
  }
}

/// Body statement for a surface that specifies a sequence of curves that build
/// a single outer trimming loop.
class TrimStatement implements ObjStatement {
  /// The [Curve2Instance]s that define the trimming loop.
  ///
  /// The individual curves must lie end-to-end to form a closed loop which does
  /// not intersect itself and which lies within the parameter range specified
  /// for the surface to which the trimming loop belongs. The loop as a whole
  /// may be oriented in either direction (clockwise or counterclockwise).
  final Iterable<Curve2Instance> curves;

  final int lineNumber;

  /// Instantiates a new [TrimStatement].
  TrimStatement(this.curves, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitTrimStatement(this);
  }

  String toSource() =>
      curves.map((n) => n.toSource()).fold('trim', (res, s) => '$res $s');
}

/// Body statement for a surface that specifies a sequence of curves to build a
/// single inner trimming loop (hole).
class HoleStatement implements ObjStatement {
  /// The [Curve2Instance]s that define the trimming loop.
  ///
  /// The individual curves must lie end-to-end to form a closed loop which does
  /// not intersect itself and which lies within the parameter range specified
  /// for the surface to which the trimming loop belongs. The loop as a whole
  /// may be oriented in either direction (clockwise or counterclockwise).
  final Iterable<Curve2Instance> curves;

  final int lineNumber;

  /// Instantiates a new [HoleStatement].
  HoleStatement(this.curves, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitHoleStatement(this);
  }

  String toSource() =>
      curves.map((n) => n.toSource()).fold('hole', (res, s) => '$res $s');
}

/// Body statement for a surface that specifies a sequence of curves which lie
/// on the given surface to build a single special curve.
///
/// Each special curve should be included in any triangulation of the surface.
/// This means that the line formed by approximating the special curve with a
/// sequence of straight line segments should actually appear as a sequence of
/// triangle edges in the final triangulation of the surface.
class ScrvStatement implements ObjStatement {
  /// The [Curve2Instance]s that define the special curve.
  final Iterable<Curve2Instance> curves;

  final int lineNumber;

  /// Instantiates a new [ScrvStatement].
  ScrvStatement(this.curves, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitScrvStatement(this);
  }

  String toSource() =>
      curves.map((n) => n.toSource()).fold('scrv', (res, s) => '$res $s');
}

/// Body statement for free-form geometry (curves and surfaces) that specifies
/// special geometric points to be associated with a curve or surface.
class SpStatement implements ObjStatement {
  /// The reference numbers of the parameter space vertices that specify the
  /// special points.
  ///
  /// For special points on space curves and trimming curves, the parameter
  /// space vertices must be 1D. For special points on surfaces, the parameter
  /// vertices must be 2D.
  final Iterable<int> vpNums;

  final int lineNumber;

  /// Instantiates a new [SpStatement].
  SpStatement(this.vpNums, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitSpStatement(this);
  }

  String toSource() =>
      vpNums.map((n) => n.toString()).fold('sp', (res, s) => '$res $s');
}

/// Specifies the end of a body statement block for free-form geometry (curves
/// and surfaces).
class EndStatement implements ObjStatement {
  final int lineNumber;

  /// Instantiates a new [EndStatement].
  EndStatement({this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitEndStatement(this);
  }

  String toSource() => 'end';
}

/// Specifies connectivity between two surfaces.
///
/// Specifies connectivity between two surfaces `A` and `B`, identified by
/// [surfANum] and [surfBNum] respectively. The surfaces should be connected
/// along [curveA] and [curveB] respectively. If surface `A` and surface `B` are
/// in different merging groups (see the [MgStatement]), then the connectivity
/// will be ignored.
///
/// The two curves and their starting and ending parameters should all map to
/// the same curve and starting and ending points in object space.
class ConStatement implements ObjStatement {
  /// The reference number for surface `A`.
  final int surfANum;

  /// The [Curve2Instance] for surface `A`.
  final Curve2Instance curveA;

  /// The reference number for surface `B`.
  final int surfBNum;

  /// The [Curve2Instance] for surface `B`.
  final Curve2Instance curveB;

  final int lineNumber;

  /// Instantiates a new [ConStatement].
  ConStatement(this.surfANum, this.curveA, this.surfBNum, this.curveB,
      {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitConStatement(this);
  }

  String toSource() =>
      'con $surfANum ${curveA.toSource()} $surfBNum ${curveB.toSource()}';
}

/// State setting statement that specifies the group name(s) for the elements
/// that follow it.
///
/// Elements can have multiple group names. If a [GStatement] specifies multiple
/// group names, then the elements that follows belong to all groups.
class GStatement implements ObjStatement {
  /// The group names specified by this [GStatement].
  ///
  /// Letters, numbers, and combinations of letters and numbers are accepted for
  /// group names. If a [GStatement] specifies multiple group names, then the
  /// elements that follows belong to all groups.
  ///
  /// The default group name is `default`.
  final Iterable<String> groupNames;

  final int lineNumber;

  /// Instantiates a new [GStatement].
  GStatement(this.groupNames, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitGStatement(this);
  }

  String toSource() => groupNames.fold('g', (res, s) => '$res $s');
}

/// State setting statement that sets the smoothing group for the elements that
/// follow it.
///
/// When calculating vertex normals by interpolating the surrounding face
/// normals, faces that do not belong to the same smoothing group as the
/// vertex's face should not be taken into account. If vertex normals are
/// explicitly defined for a face element, then these vertex normals should be
/// used and the smoothing group should be ignored.
class SStatement implements ObjStatement {
  /// The smoothing group set by this [SStatement].
  ///
  /// A value of `0` indicates that smoothing groups are turned of for the
  /// elements that follow this statement.
  ///
  /// For free-form surfaces, smoothing groups are either turned on or off;
  /// there is no difference between values greater than `0`.
  final int smoothingGroup;

  final int lineNumber;

  /// Instantiates a new [SStatement].
  SStatement(this.smoothingGroup, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitSStatement(this);
  }

  String toSource() {
    if (smoothingGroup == 0) {
      return 's off';
    } else {
      return 's $smoothingGroup';
    }
  }
}

/// State setting statement that sets the merging group and merge resolution for
/// the free-form surfaces that follow it.
///
/// Adjacency detection is performed only within groups, never between groups.
/// Connectivity between surfaces in different merging groups is not allowed.
/// Surfaces in the same merging group are merged together along edges that are
/// within the [resolution] distance apart.
///
/// NOTE: Adjacency detection is an expensive numerical comparison process. It
/// is best to restrict this process to as small a domain as possible by using
/// small merging groups.
class MgStatement implements ObjStatement {
  /// The merging group set by this [MgStatement].
  ///
  /// A value of `0` indicates that merging groups are turned of for the
  /// elements that follow this statement.
  final int mergingGroup;

  /// The maximum distance between two surfaces that will be merged together.
  ///
  /// The resolution must be a value greater than `0.0`. This is a required
  /// argument only when using merging groups (that is, [mergingGroup] is not
  /// `0`).
  final double resolution;

  final int lineNumber;

  /// Instantiates a new [MgStatement].
  MgStatement(this.mergingGroup, this.resolution, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitMgStatement(this);
  }

  String toSource() {
    if (mergingGroup == 0) {
      return 'mg off';
    } else {
      return 'mg $mergingGroup $resolution';
    }
  }
}

/// State setting statement specifies an object name for the elements that
/// follow it.
class OStatement implements ObjStatement {
  /// The object name set by this [OStatement].
  final String objectName;

  final int lineNumber;

  /// Instantiates a new [OStatement].
  OStatement(this.objectName, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitOStatement(this);
  }

  String toSource() => 'o $objectName';
}

/// State setting statement that turns bevel interpolation on or off.
///
/// It works only with beveled objects, that is, objects with sides separated by
/// beveled faces.
///
/// Bevel interpolation uses normal vector interpolation to give an illusion of
/// roundness to a flat bevel. It does not affect the smoothing of non-bevelled
/// faces.
class BevelStatement implements ObjStatement {
  /// Whether this [BevelStatement] enabled or disabled bevel interpolation.
  final bool bevelEnabled;

  final int lineNumber;

  /// Instantiates a new [BevelStatement].
  BevelStatement(this.bevelEnabled, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitBevelStatement(this);
  }

  String toSource() {
    if (bevelEnabled) {
      return 'bevel on';
    } else {
      return 'bevel off';
    }
  }
}

/// State setting statement that turns color interpolation on or off.
///
/// Color interpolation creates a blend across the surface of a polygon between
/// the materials assigned to its vertices. This creates a blending of colors
/// across a face element.
///
/// To support color interpolation, materials must be assigned per vertex, not
/// per element. The illumination models for all materials of vertices attached
/// to the polygon must be the same. Color interpolation applies to the values
/// for ambient (`Ka`), diffuse (`Kd`), specular (`Ks`), and specular highlight
/// (`Ns`) material properties.
class CInterpStatement implements ObjStatement {
  /// Whether this [CInterpStatement] enabled or disabled color interpolation.
  final bool colorInterpolationEnabled;

  final int lineNumber;

  /// Instantiates a new [CInterpStatement].
  CInterpStatement(this.colorInterpolationEnabled, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCInterpStatement(this);
  }

  String toSource() {
    if (colorInterpolationEnabled) {
      return 'c_interp on';
    } else {
      return 'c_interp off';
    }
  }
}

/// State setting statement that turns dissolve interpolation on or off.
///
/// Dissolve interpolation creates an interpolation or blend across a polygon
/// between the dissolve (`d`) values of the materials assigned to its vertices.
/// This feature is used to create effects exhibiting varying degrees of
/// apparent transparency, as in glass or clouds.
///
/// To support dissolve interpolation, materials must be assigned per vertex,
/// not per element. All the materials assigned to the vertices involved in the
/// dissolve interpolation must contain a dissolve factor command to specify a
/// dissolve.
class DInterpStatement implements ObjStatement {
  /// Whether this [DInterpStatement] enabled or disabled dissolve
  /// interpolation.
  final bool dissolveInterpolationEnabled;

  final int lineNumber;

  /// Instantiates a new [DInterpStatement].
  DInterpStatement(this.dissolveInterpolationEnabled, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitDInterpStatement(this);
  }

  String toSource() {
    if (dissolveInterpolationEnabled) {
      return 'd_interp on';
    } else {
      return 'd_interp off';
    }
  }
}

/// State setting statement that sets the level of detail to be displayed.
///
/// The level of detail feature lets you control which elements of an object are
/// displayed.
class LodStatement implements ObjStatement {
  /// The level of detail to be displayed.
  ///
  /// When you set the level of detail to 0 or omit the lod statement, all
  /// elements are displayed.  Specifying an integer between `1` and `100` sets
  /// the level of detail to be displayed when reading the `.obj` file.
  final int level;

  final int lineNumber;

  /// Instantiates a new [LodStatement].
  LodStatement(this.level, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitLodStatement(this);
  }

  String toSource() => 'lod $level';
}

/// A state setting statement that specifies the map library file for the
/// texture map definitions set with the [UsemapStatement].
///
/// You can specify multiple filenames with a [MaplibStatement]. If multiple
/// filenames are specified, the first file listed is searched first for the map
/// definition, the second file is searched next, and so on.
class MaplibStatement implements ObjStatement {
  /// The names of the library files where the texture maps are defined.
  ///
  /// If multiple filenames are specified, the first file listed is searched
  /// first for a map definition, the second file is searched next, and so on.
  final Iterable<String> filenames;

  final int lineNumber;

  /// Instantiates a new [MaplibStatement].
  MaplibStatement(this.filenames, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitMaplibStatement(this);
  }

  String toSource() => filenames.fold('maplib', (res, s) => '$res $s');
}

/// State setting statement that specifies the texture map name for the elements
/// following it.
///
/// If you specify texture mapping for a face without texture vertices, then the
/// texture map will be ignored.
class UsemapStatement implements ObjStatement {
  /// The name of the texture map.
  ///
  /// A value of `null` indicates that no texture map should be used.
  final String mapName;

  final int lineNumber;

  /// Instantiates a new [UsemapStatement].
  UsemapStatement(this.mapName, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitUsemapStatement(this);
  }

  String toSource() {
    if (mapName == null) {
      return 'usemap off';
    } else {
      return 'usemap $mapName';
    }
  }
}

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
}

/// A state setting statement that specifies the material library file for the
/// material definitions set with the [UsemtlStatement].
///
/// You can specify multiple filenames with a [MtllibStatement]. If multiple
/// filenames are specified, the first file listed is searched first for the
/// material definition, the second file is searched next, and so on.
class MtllibStatement implements ObjStatement {
  /// The names of the library files where the texture maps are defined.
  ///
  /// If multiple filenames are specified, the first file listed is searched
  /// first for a material definition, the second file is searched next, and so
  /// on.
  final Iterable<String> filenames;

  final int lineNumber;

  /// Instantiates a new [MtllibStatement].
  MtllibStatement(this.filenames, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitMtllibStatement(this);
  }

  String toSource() => filenames.fold('mtllib', (res, s) => '$res $s');
}

/// Specifies the shadow object filename.
///
/// A shadow object is used to cast shadows for the current object. The shadow
/// object is invisible except for its shadow.
///
/// An object should cast shadows only if it has a shadow object. You can use an
/// object as its own shadow object. However, a simplified version of the
/// original object is usually preferable for shadow objects, since shadow
/// casting can greatly increase rendering time.
///
/// Only one shadow object can be specified in a object file. If more than one
/// shadow object is specified, then the last one specified should be used.
class ShadowObjStatement implements ObjStatement {
  /// The filename for the shadow object.
  ///
  /// Any valid object filename can be used for the shadow object. The object
  /// file can be an `.obj` or `.mod` file. If a filename is given without an
  /// extension, then an extension of `.obj` should be assumed.
  final String filename;

  final int lineNumber;

  /// Instantiates a new [ShadowObjStatement].
  ShadowObjStatement(this.filename, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitShadowObjStatement(this);
  }

  String toSource() => 'shadow_obj $filename';
}

/// Specifies the trace object filename.
///
/// A trace object is used in generating reflections of the current object on
/// reflective surfaces. The trace object is invisible except for its
/// reflection.
///
/// An object should appear in reflections only if it has a trace object. You
/// can use an object as its own trace object. However, a simplified version of
/// the original object is usually preferable for trace objects, since ray
/// tracing can greatly increase rendering time.
///
/// Only one trace object can be specified in a object file. If more than one
/// trace object is specified, then the last one specified should be used.
class TraceObjStatement implements ObjStatement {
  /// The filename for the trace object.
  ///
  /// Any valid object filename can be used for the trace object. The object
  /// file can be an `.obj` or `.mod` file. If a filename is given without an
  /// extension, then an extension of `.obj` should be assumed.
  final String filename;

  final int lineNumber;

  /// Instantiates a new [TraceObjStatement].
  TraceObjStatement(this.filename, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitTraceObjStatement(this);
  }

  String toSource() => 'trace_obj $filename';
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
  SurfaceConstantParametricSubdivisionB(this.resolutionU, this.resolutionV);

  String toSource() => 'cparmb $resolution';
}

/// Surface constant spatial subdivision.
///
/// The surface is subdivided in rectangular regions until the length in real
/// space of any rectangle edge is less than the [maxLength]. These rectangular
/// regions are then triangulated.
class SurfaceConstantSpatialSubdivision implements SurfaceApproximationTechnique {
  final STech type = STech.constantSpatialSubdivision;

  /// The maximum allowed length in real space of any rectangle edge.
  ///
  /// The smaller the value, the finer the resolution.
  final double maxLength;

  /// Creates a new [SurfaceConstantSpatialSubdivision] instance.
  SurfaceConstantSpatialSubdivision(this.maxLength);

  String toSource() => 'cspace $maxLength';
}

/// Surface curvature-dependent subdivision using separate resolution parameters
/// for the maximum distance and the maximum angle.
///
/// The surface is subdivided in rectangular regions until 1) the distance in
/// real space between the approximating rectangle and the actual surface is
/// less than the [maxDistance] (approximately) and 2) the angle in degrees
/// between surface normals at the corners of the rectangle is less than the
/// [maxAngle]. Following subdivision, the regions are triangulated.
class SurfaceCurvatureDependentSubdivision implements SurfaceApproximationTechnique {
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
}

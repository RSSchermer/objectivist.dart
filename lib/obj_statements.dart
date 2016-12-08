library obj_statements;

import 'package:quiver/collection.dart';
import 'package:quiver/core.dart';

part 'src/obj_statements/v_statement.dart';
part 'src/obj_statements/vt_statement.dart';
part 'src/obj_statements/vn_statement.dart';
part 'src/obj_statements/vp_statement.dart';
part 'src/obj_statements/cstype_statement.dart';
part 'src/obj_statements/deg_statement.dart';
part 'src/obj_statements/bmat_statement.dart';
part 'src/obj_statements/step_statement.dart';
part 'src/obj_statements/p_statement.dart';
part 'src/obj_statements/l_statement.dart';
part 'src/obj_statements/f_statement.dart';
part 'src/obj_statements/curv_statement.dart';
part 'src/obj_statements/curv2_statement.dart';
part 'src/obj_statements/surf_statement.dart';
part 'src/obj_statements/parm_statement.dart';
part 'src/obj_statements/trim_statement.dart';
part 'src/obj_statements/hole_statement.dart';
part 'src/obj_statements/scrv_statement.dart';
part 'src/obj_statements/sp_statement.dart';
part 'src/obj_statements/end_statement.dart';
part 'src/obj_statements/con_statement.dart';
part 'src/obj_statements/g_statement.dart';
part 'src/obj_statements/s_statement.dart';
part 'src/obj_statements/mg_statement.dart';
part 'src/obj_statements/o_statement.dart';
part 'src/obj_statements/bevel_statement.dart';
part 'src/obj_statements/c_interp_statement.dart';
part 'src/obj_statements/d_interp_statement.dart';
part 'src/obj_statements/lod_statement.dart';
part 'src/obj_statements/maplib_statement.dart';
part 'src/obj_statements/usemap_statement.dart';
part 'src/obj_statements/usemtl_statement.dart';
part 'src/obj_statements/mtllib_statement.dart';
part 'src/obj_statements/shadow_obj_statement.dart';
part 'src/obj_statements/trace_obj_statement.dart';
part 'src/obj_statements/ctech_statement.dart';
part 'src/obj_statements/stech_statement.dart';

/// Enumerates the parameter directions.
enum ParameterDirection { u, v }

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

/// A pair of numbers or which [vNum] is the reference number for a geometric
/// vertex and [vtNum] is the reference number of a texture vertex.
class VertexNumPair {
  /// A reference number for a geometric vertex.
  final int vNum;

  /// A reference number for a texture vertex.
  final int vtNum;

  /// Instantiates a new [VertexNumPair].
  VertexNumPair(this.vNum, [this.vtNum]);

  /// A source code representation of the number pair.
  String toSource() {
    if (vtNum != null) {
      return '$vNum/$vtNum';
    } else {
      return vNum.toString();
    }
  }

  String toString() => '($vNum, $vtNum)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is VertexNumPair && other.vNum == vNum && other.vtNum == vtNum;

  int get hashCode => hash2(vNum, vtNum);
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
  VertexNumTriple(this.vNum, [this.vtNum, this.vnNum]);

  /// A source code representation of the number pair.
  String toSource() {
    if (vtNum != null && vnNum != null) {
      return '$vNum/$vtNum/$vnNum';
    } else if (vtNum != null) {
      return '$vNum/$vtNum';
    } else if (vnNum != null) {
      return '$vNum//$vnNum';
    } else {
      return vNum.toString();
    }
  }

  String toString() => '($vNum, $vtNum, $vnNum)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is VertexNumTriple &&
          other.vNum == vNum &&
          other.vtNum == vtNum &&
          other.vnNum == vnNum;

  int get hashCode => hash3(vNum, vtNum, vnNum);
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

  String toString() => 'Curve2Instance($start, $end, $curve2Num)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is Curve2Instance &&
          other.start == start &&
          other.end == end &&
          other.curve2Num == curve2Num;
}

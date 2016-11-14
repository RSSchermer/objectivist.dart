library obj_reading.statement_builders;

import 'package:objectivist/obj_statements.dart';
import 'package:objectivist/obj_reading/errors.dart';

part 'src/statement_builders/v_statement_builder.dart';
part 'src/statement_builders/vt_statement_builder.dart';
part 'src/statement_builders/vn_statement_builder.dart';
part 'src/statement_builders/vp_statement_builder.dart';
part 'src/statement_builders/cstype_statement_builder.dart';
part 'src/statement_builders/deg_statement_builder.dart';
part 'src/statement_builders/bmat_statement_builder.dart';
part 'src/statement_builders/step_statement_builder.dart';
part 'src/statement_builders/p_statement_builder.dart';
part 'src/statement_builders/l_statement_builder.dart';
part 'src/statement_builders/f_statement_builder.dart';
part 'src/statement_builders/curv_statement_builder.dart';
part 'src/statement_builders/curv2_statement_builder.dart';
part 'src/statement_builders/surf_statement_builder.dart';
part 'src/statement_builders/parm_statement_builder.dart';
part 'src/statement_builders/trim_statement_builder.dart';
part 'src/statement_builders/hole_statement_builder.dart';
part 'src/statement_builders/scrv_statement_builder.dart';
part 'src/statement_builders/sp_statement_builder.dart';
part 'src/statement_builders/end_statement_builder.dart';
part 'src/statement_builders/con_statement_builder.dart';
part 'src/statement_builders/g_statement_builder.dart';
part 'src/statement_builders/s_statement_builder.dart';
part 'src/statement_builders/mg_statement_builder.dart';
part 'src/statement_builders/o_statement_builder.dart';
part 'src/statement_builders/bevel_statement_builder.dart';
part 'src/statement_builders/c_interp_statement_builder.dart';
part 'src/statement_builders/d_interp_statement_builder.dart';
part 'src/statement_builders/lod_statement_builder.dart';
part 'src/statement_builders/maplib_statement_builder.dart';
part 'src/statement_builders/usemap_statement_builder.dart';
part 'src/statement_builders/usemtl_statement_builder.dart';
part 'src/statement_builders/mtllib_statement_builder.dart';
part 'src/statement_builders/shadow_obj_statement_builder.dart';
part 'src/statement_builders/trace_obj_statement_builder.dart';
part 'src/statement_builders/ctech_statement_builder.dart';
part 'src/statement_builders/stech_statement_builder.dart';

abstract class ObjStatementBuilder {
  void addStringArgument(String argument);

  void addIntArgument(int argument);

  void addIntPairArgument(IntPair argument);

  void addIntTripleArgument(IntTriple argument);

  void addDoubleArgument(double argument);

  ObjStatementResult build();
}

class ObjStatementResult {
  final ObjStatement statement;

  final Iterable<ObjError> errors;

  ObjStatementResult.success(this.statement) : errors = [];

  ObjStatementResult.failure(this.errors) : statement = null;

  bool get isSuccess => statement != null;

  bool get isFailure => !isSuccess;
}

class IntPair {
  static IntPair parse(String string) {
    final parts = string.split('/');

    return new IntPair(int.parse(parts[0]), int.parse(parts[1]));
  }

  final int value1;

  final int value2;

  IntPair(this.value1, this.value2);
}

class IntTriple {
  static IntTriple parse(String string) {
    final parts = string.split('/');
    final value1 = int.parse(parts[0]);
    final value2 = parts[1] != '' ? int.parse(parts[1]) : null;
    final value3 = int.parse(parts[2]);

    return new IntTriple(value1, value2, value3);
  }

  final int value1;

  final int value2;

  final int value3;

  IntTriple(this.value1, this.value2, this.value3);
}

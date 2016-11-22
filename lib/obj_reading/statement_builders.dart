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

/// Defines the interface for [ObjStatement] builders.
///
/// [ObjStatement] builders build [ObjStatement]s by adding arguments one by
/// one. Once all arguments have been added, call [build] to retrieve the
/// [ObjStatementResult].
abstract class ObjStatementBuilder {
  /// Adds a [String] type [argument] to the statement that is being build.
  void addStringArgument(String argument);

  /// Adds a [Int] type [argument] to the statement that is being build.
  void addIntArgument(int argument);

  /// Adds a [IntPair] type [argument] to the statement that is being build.
  void addIntPairArgument(IntPair argument);

  /// Adds a [IntTriple] type [argument] to the statement that is being build.
  void addIntTripleArgument(IntTriple argument);

  /// Adds a [double] type [argument] to the statement that is being build.
  void addDoubleArgument(double argument);

  /// Attempts to build the statement from the arguments that have been
  /// supplied.
  ///
  /// Returns an [ObjStatementResult] which will either hold the [ObjStatement]
  /// constructed by this builder, or a collection of errors if this
  /// [ObjStatementBuilder] failed to construct an [ObjStatement] due to
  /// problems in the argument list (e.g. too few arguments, too many arguments,
  /// arguments of incorrect types).
  ObjStatementResult build();
}

/// Either an [ObjStatement] or a collection of errors if an [ObjStatement]
/// could not be constructed.
class ObjStatementResult {
  /// The [ObjStatement] if this [ObjStatementResult] was successful or `null`
  /// if it failed.
  final ObjStatement statement;

  /// The [ObjReadingError]s if this [ObjStatementResult] failed.
  ///
  /// Is empty if this [ObjStatementResult] was successful.
  final Iterable<ObjReadingError> errors;

  ObjStatementResult._success(this.statement) : errors = [];

  ObjStatementResult._failure(this.errors) : statement = null;

  /// Whether this [ObjStatementResult] was successful and contains a
  /// [statement] or failed and contains [errors].
  bool get isSuccess => statement != null;

  /// Whether this [ObjStatementResult] failed and contains [errors] or was
  /// successful and contains a [statement].
  bool get isFailure => !isSuccess;
}

/// A pair of integers.
class IntPair {
  /// Parses the [string] into an [IntPair].
  ///
  /// The [string] should consist of two valid integer strings joined by a
  /// forward slash, without spaces. Valid examples:
  ///
  /// - `1/2`
  /// - `-8/345`
  ///
  static IntPair parse(String string) {
    final parts = string.split('/');

    return new IntPair(int.parse(parts[0]), int.parse(parts[1]));
  }

  /// The first integer in this [IntPair].
  final int value1;

  /// The second integer in this [IntPair].
  final int value2;

  /// Instantiates a new [IntPair].
  IntPair(this.value1, this.value2);
}

/// A triple of integers.
class IntTriple {
  /// Parses the [string] into an [IntPair].
  ///
  /// The [string] should consist of three valid integer strings joined by a
  /// forward slash, without spaces. The second integer may be omitted, in which
  /// case the [string] should consist of a valid integer string, followed by 2
  /// adjoining slashes, followed by another valid integer string. Valid
  /// examples:
  ///
  /// - `1/2/3`
  /// - `-8/345/-12`
  /// - `1//3`
  ///
  static IntTriple parse(String string) {
    final parts = string.split('/');
    final value1 = int.parse(parts[0]);
    final value2 = parts[1] != '' ? int.parse(parts[1]) : null;
    final value3 = int.parse(parts[2]);

    return new IntTriple(value1, value2, value3);
  }

  /// The first integer in this [IntTriple].
  final int value1;

  /// The second integer in this [IntTriple].
  final int value2;

  /// The third integer in this [IntTriple].
  final int value3;

  /// Instantiates a new [IntTriple].
  IntTriple(this.value1, this.value2, this.value3);
}

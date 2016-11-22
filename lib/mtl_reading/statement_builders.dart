library mtl_reading.statement_builders;

import 'package:objectivist/mtl_statements.dart';
import 'package:objectivist/mtl_reading/errors.dart';

part 'src/statement_builders/_color_map_statement_builder.dart';
part 'src/statement_builders/_color_statement_builder.dart';
part 'src/statement_builders/_scalar_map_statement_builder.dart';

part 'src/statement_builders/bump_statement_builder.dart';
part 'src/statement_builders/d_statement_builder.dart';
part 'src/statement_builders/decal_statement_builder.dart';
part 'src/statement_builders/disp_statement_builder.dart';
part 'src/statement_builders/illum_statement_builder.dart';
part 'src/statement_builders/ka_statement_builder.dart';
part 'src/statement_builders/kd_statement_builder.dart';
part 'src/statement_builders/ks_statement_builder.dart';
part 'src/statement_builders/map_aat_statement_builder.dart';
part 'src/statement_builders/map_d_statement_builder.dart';
part 'src/statement_builders/map_ka_statement_builder.dart';
part 'src/statement_builders/map_kd_statement_builder.dart';
part 'src/statement_builders/map_ks_statement_builder.dart';
part 'src/statement_builders/map_ns_statement_builder.dart';
part 'src/statement_builders/newmtl_statement_builder.dart';
part 'src/statement_builders/ni_statement_builder.dart';
part 'src/statement_builders/ns_statement_builder.dart';
part 'src/statement_builders/refl_statement_builder.dart';
part 'src/statement_builders/sharpness_statement_builder.dart';
part 'src/statement_builders/tf_statement_builder.dart';

/// Defines the interface for [MtlStatement] builders.
///
/// [MtlStatement] builders build [MtlStatement]s by adding arguments one by
/// one. Once all arguments have been added, call [build] to retrieve the
/// [MtlStatementResult].
abstract class MtlStatementBuilder {
  /// Adds a [String] type [argument] to the statement that is being build.
  void addStringArgument(String argument);

  /// Adds a [Int] type [argument] to the statement that is being build.
  void addIntArgument(int argument);

  /// Adds a [double] type [argument] to the statement that is being build.
  void addDoubleArgument(double argument);

  /// Attempts to build the statement from the arguments that have been
  /// supplied.
  ///
  /// Returns an [MtlStatementResult] which will either hold the [MtlStatement]
  /// constructed by this builder, or a collection of errors if this
  /// [ObjStatementBuilder] failed to construct an [MtlStatement] due to
  /// problems in the argument list (e.g. too few arguments, too many arguments,
  /// arguments of incorrect types).
  MtlStatementResult build();
}

/// Either an [MtlStatement] or a collection of errors if an [MtlStatement]
/// could not be constructed.
class MtlStatementResult {
  /// The [MtlStatement] if this [MtlStatementResult] was successful or `null`
  /// if it failed.
  final MtlStatement statement;

  /// The [MtlReadingError]s if this [MtlStatementResult] failed.
  ///
  /// Is empty if this [MtlStatementResult] was successful.
  final Iterable<MtlReadingError> errors;

  MtlStatementResult._success(this.statement) : errors = [];

  MtlStatementResult._failure(this.errors) : statement = null;

  /// Whether this [MtlStatementResult] was successful and contains a
  /// [statement] or failed and contains [errors].
  bool get isSuccess => statement != null;

  /// Whether this [MtlStatementResult] failed and contains [errors] or was
  /// successful and contains a [statement].
  bool get isFailure => !isSuccess;
}

String _positionToString(int position) {
  final adjusted = position + 1;

  switch (adjusted % 10) {
    case 1:
      return '${adjusted}st';
    case 2:
      return '${adjusted}nd';
    default:
      return '${adjusted}th';
  }
}

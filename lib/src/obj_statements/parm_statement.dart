part of obj_statements;

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

  String toString() =>
      'ParmStatement($direction, $parameterValues, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is ParmStatement &&
          other.direction == direction &&
          listsEqual(
              other.parameterValues.toList(), parameterValues.toList()) &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

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

  String toString() =>
      'BmatStatement($direction, $values, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is BmatStatement &&
          other.direction == direction &&
          listsEqual(other.values.toList(), values.toList()) &&
          other.lineNumber == lineNumber;
}

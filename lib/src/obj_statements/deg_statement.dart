part of obj_statements;

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

  String toString() =>
      'DegStatement($degreeU, $degreeV, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is DegStatement &&
          other.degreeU == degreeU &&
          other.degreeV == degreeV &&
          other.lineNumber == lineNumber;
}

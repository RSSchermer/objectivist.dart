part of obj_statements;

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

  String toString() => 'SpStatement($vpNums, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SpStatement &&
          listsEqual(other.vpNums.toList(), vpNums.toList()) &&
          other.lineNumber == lineNumber;
}

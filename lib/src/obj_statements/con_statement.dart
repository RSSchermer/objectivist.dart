part of obj_statements;

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

  String toString() =>
      'ConStatement($surfANum, $curveA, $surfBNum, $curveB, lineNumber: '
      '$lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is ConStatement &&
          other.surfANum == surfANum &&
          other.curveA == curveA &&
          other.surfBNum == surfBNum &&
          other.curveB == curveB &&
          other.lineNumber == lineNumber;
}

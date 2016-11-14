part of obj_statements;

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

  String toString() => 'BevelStatement($bevelEnabled, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is BevelStatement &&
          other.bevelEnabled == bevelEnabled &&
          other.lineNumber == lineNumber;
}

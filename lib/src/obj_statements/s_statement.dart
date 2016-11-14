part of obj_statements;

/// State setting statement that sets the smoothing group for the elements that
/// follow it.
///
/// When calculating vertex normals by interpolating the surrounding face
/// normals, faces that do not belong to the same smoothing group as the
/// vertex's face should not be taken into account. If vertex normals are
/// explicitly defined for a face element, then these vertex normals should be
/// used and the smoothing group should be ignored.
class SStatement implements ObjStatement {
  /// The smoothing group set by this [SStatement].
  ///
  /// A value of `0` indicates that smoothing groups are turned of for the
  /// elements that follow this [SStatement].
  ///
  /// For free-form surfaces, smoothing groups are either turned on or off;
  /// there is no difference between values greater than `0`.
  final int smoothingGroup;

  final int lineNumber;

  /// Instantiates a new [SStatement].
  SStatement(this.smoothingGroup, {this.lineNumber});

  /// Whether or not smoothing groups are turned on for elements that follow
  /// this [SStatement].
  bool get isOn => smoothingGroup > 0;

  /// Whether or not smoothing groups are turned off for elements that follow
  /// this [SStatement].
  bool get isOff => smoothingGroup <= 0;

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitSStatement(this);
  }

  String toSource() {
    if (isOff) {
      return 's off';
    } else {
      return 's $smoothingGroup';
    }
  }

  String toString() => 'SStatement($smoothingGroup, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SStatement &&
          other.smoothingGroup == smoothingGroup &&
          other.lineNumber == lineNumber;
}

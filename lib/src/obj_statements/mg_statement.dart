part of obj_statements;

/// State setting statement that sets the merging group and merge resolution for
/// the free-form surfaces that follow it.
///
/// Adjacency detection is performed only within groups, never between groups.
/// Connectivity between surfaces in different merging groups is not allowed.
/// Surfaces in the same merging group are merged together along edges that are
/// within the [resolution] distance apart.
///
/// NOTE: Adjacency detection is an expensive numerical comparison process. It
/// is best to restrict this process to as small a domain as possible by using
/// small merging groups.
class MgStatement implements ObjStatement {
  /// The merging group set by this [MgStatement].
  ///
  /// A value of `0` indicates that merging groups are turned of for the
  /// elements that follow this [MgStatement].
  final int mergingGroup;

  /// The maximum distance between two surfaces that will be merged together.
  ///
  /// The resolution must be a value greater than `0.0`. This is a required
  /// argument only when using merging groups (that is, [mergingGroup] is not
  /// `0`).
  final double resolution;

  final int lineNumber;

  /// Instantiates a new [MgStatement].
  MgStatement(this.mergingGroup, this.resolution, {this.lineNumber});

  /// Whether or not smoothing groups are turned on for elements that follow
  /// this [MgStatement].
  bool get isOn => mergingGroup > 0;

  /// Whether or not smoothing groups are turned off for elements that follow
  /// this [MgStatement].
  bool get isOff => mergingGroup <= 0;

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitMgStatement(this);
  }

  String toSource() {
    if (isOff) {
      return 'mg off';
    } else {
      return 'mg $mergingGroup $resolution';
    }
  }

  String toString() =>
      'MgStatement($mergingGroup, $resolution, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is MgStatement &&
          other.mergingGroup == mergingGroup &&
          other.resolution == resolution &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

/// State setting statement that specifies the group name(s) for the elements
/// that follow it.
///
/// Elements can have multiple group names. If a [GStatement] specifies multiple
/// group names, then the elements that follows belong to all groups.
class GStatement implements ObjStatement {
  /// The group names specified by this [GStatement].
  ///
  /// Letters, numbers, and combinations of letters and numbers are accepted for
  /// group names. If a [GStatement] specifies multiple group names, then the
  /// elements that follows belong to all groups.
  ///
  /// The default group name is `default`.
  final Iterable<String> groupNames;

  final int lineNumber;

  /// Instantiates a new [GStatement].
  GStatement(this.groupNames, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitGStatement(this);
  }

  String toSource() => groupNames.fold('g', (res, s) => '$res $s');

  String toString() => 'GStatement($groupNames, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is GStatement &&
          listsEqual(other.groupNames.toList(), groupNames.toList()) &&
          other.lineNumber == lineNumber;
}

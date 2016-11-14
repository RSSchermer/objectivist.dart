part of obj_statements;

/// State setting statement that sets the level of detail to be displayed.
///
/// The level of detail feature lets you control which elements of an object are
/// displayed.
class LodStatement implements ObjStatement {
  /// The level of detail to be displayed.
  ///
  /// When you set the level of detail to 0 or omit the lod statement, all
  /// elements are displayed.  Specifying an integer between `1` and `100` sets
  /// the level of detail to be displayed when reading the `.obj` file.
  final int level;

  final int lineNumber;

  /// Instantiates a new [LodStatement].
  LodStatement(this.level, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitLodStatement(this);
  }

  String toSource() => 'lod $level';

  String toString() => 'LodStatement($level, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is LodStatement &&
          other.level == level &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

/// State setting statement that specifies the texture map name for the elements
/// following it.
///
/// If you specify texture mapping for a face without texture vertices, then the
/// texture map will be ignored.
class UsemapStatement implements ObjStatement {
  /// The name of the texture map.
  ///
  /// A value of `null` indicates that no texture map should be used.
  final String mapName;

  final int lineNumber;

  /// Instantiates a new [UsemapStatement].
  UsemapStatement(this.mapName, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitUsemapStatement(this);
  }

  String toSource() {
    if (mapName == null) {
      return 'usemap off';
    } else {
      return 'usemap $mapName';
    }
  }

  String toString() => 'UsemapStatement($mapName, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is UsemapStatement &&
          other.mapName == mapName &&
          other.lineNumber == lineNumber;
}

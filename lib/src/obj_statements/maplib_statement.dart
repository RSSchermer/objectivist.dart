part of obj_statements;

/// A state setting statement that specifies the map library file for the
/// texture map definitions set with the [UsemapStatement].
///
/// You can specify multiple filenames with a [MaplibStatement]. If multiple
/// filenames are specified, the first file listed is searched first for the map
/// definition, the second file is searched next, and so on.
class MaplibStatement implements ObjStatement {
  /// The names of the library files where the texture maps are defined.
  ///
  /// If multiple filenames are specified, the first file listed is searched
  /// first for a map definition, the second file is searched next, and so on.
  final Iterable<String> filenames;

  final int lineNumber;

  /// Instantiates a new [MaplibStatement].
  MaplibStatement(this.filenames, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitMaplibStatement(this);
  }

  String toSource() => filenames.fold('maplib', (res, s) => '$res $s');

  String toString() => 'MaplibStatement($filenames, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is MaplibStatement &&
          listsEqual(other.filenames.toList(), filenames.toList()) &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

/// A state setting statement that specifies the material library file for the
/// material definitions set with the [UsemtlStatement].
///
/// You can specify multiple filenames with a [MtllibStatement]. If multiple
/// filenames are specified, the first file listed is searched first for the
/// material definition, the second file is searched next, and so on.
class MtllibStatement implements ObjStatement {
  /// The names of the library files where the texture maps are defined.
  ///
  /// If multiple filenames are specified, the first file listed is searched
  /// first for a material definition, the second file is searched next, and so
  /// on.
  final Iterable<String> filenames;

  final int lineNumber;

  /// Instantiates a new [MtllibStatement].
  MtllibStatement(this.filenames, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitMtllibStatement(this);
  }

  String toSource() => filenames.fold('mtllib', (res, s) => '$res $s');

  String toString() => 'MtllibStatement($filenames, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is MtllibStatement &&
          listsEqual(other.filenames.toList(), filenames.toList()) &&
          other.lineNumber == lineNumber;
}

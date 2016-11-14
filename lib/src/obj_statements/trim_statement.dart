part of obj_statements;

/// Body statement for a surface that specifies a sequence of curves that build
/// a single outer trimming loop.
class TrimStatement implements ObjStatement {
  /// The [Curve2Instance]s that define the trimming loop.
  ///
  /// The individual curves must lie end-to-end to form a closed loop which does
  /// not intersect itself and which lies within the parameter range specified
  /// for the surface to which the trimming loop belongs. The loop as a whole
  /// may be oriented in either direction (clockwise or counterclockwise).
  final Iterable<Curve2Instance> curves;

  final int lineNumber;

  /// Instantiates a new [TrimStatement].
  TrimStatement(this.curves, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitTrimStatement(this);
  }

  String toSource() =>
      curves.map((n) => n.toSource()).fold('trim', (res, s) => '$res $s');

  String toString() => 'TrimStatement($curves, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is TrimStatement &&
          listsEqual(other.curves.toList(), curves.toList()) &&
          other.lineNumber == lineNumber;
}

part of obj_statements;

/// State setting statement that turns dissolve interpolation on or off.
///
/// Dissolve interpolation creates an interpolation or blend across a polygon
/// between the dissolve (`d`) values of the materials assigned to its vertices.
/// This feature is used to create effects exhibiting varying degrees of
/// apparent transparency, as in glass or clouds.
///
/// To support dissolve interpolation, materials must be assigned per vertex,
/// not per element. All the materials assigned to the vertices involved in the
/// dissolve interpolation must contain a dissolve factor command to specify a
/// dissolve.
class DInterpStatement implements ObjStatement {
  /// Whether this [DInterpStatement] enabled or disabled dissolve
  /// interpolation.
  final bool dissolveInterpolationEnabled;

  final int lineNumber;

  /// Instantiates a new [DInterpStatement].
  DInterpStatement(this.dissolveInterpolationEnabled, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitDInterpStatement(this);
  }

  String toSource() {
    if (dissolveInterpolationEnabled) {
      return 'd_interp on';
    } else {
      return 'd_interp off';
    }
  }

  String toString() => 'DInterpStatement($dissolveInterpolationEnabled, '
      'lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is DInterpStatement &&
          other.dissolveInterpolationEnabled == dissolveInterpolationEnabled &&
          other.lineNumber == lineNumber;
}

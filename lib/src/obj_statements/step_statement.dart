part of obj_statements;

/// State setting statement that sets the step size for the basis matrix curves
/// and surfaces superseding it.
///
/// When a curve or surface is being evaluated and a transition from one segment
/// or patch to the next occurs, the set of control points used is incremented
/// by the step size. The appropriate step size depends on the representation
/// type, which is expressed through the basis matrix (as set with a
/// [BmatStatement]), and on the degree (as set with a [DegStatement]). That is,
/// suppose we are given a curve with `k` control points: `(v_1 , ..., v_k)`. If
/// the curve is of degree `n`, then `n + 1` control points are needed for each
/// polynomial segment. If the step size is given as `s`, then the `i`th
/// polynomial segment, where `i = 0` is the first segment, will use the control
/// points: `(v_{i * s + 1}, ..., v_{i * s + n + 1})`.
///
/// For example, for Bezier curves, `s = n`.
///
/// For surfaces, the above description applies independently to each
/// parametric direction (see also [stepV]).
///
/// Required only for curves and surfaces that use a basis matrix. There is
/// no default, a value must be supplied.
class StepStatement implements ObjStatement {
  /// The step size in the `u` direction.
  final int stepU;

  /// The step size in the `v` direction.
  final int stepV;

  final int lineNumber;

  // TODO: make stepV an optional positional argument once Dart allows both
  // optional named and optional positional arguments in the same argument list.

  /// Instantiates a new [StepStatement].
  StepStatement(this.stepU, this.stepV, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitStepStatement(this);
  }

  String toSource() {
    if (stepV != null) {
      return 'step $stepU $stepV';
    } else {
      return 'step $stepU';
    }
  }

  String toString() => 'StepStatement($stepU, $stepV, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is StepStatement &&
          other.stepU == stepU &&
          other.stepV == stepV &&
          other.lineNumber == lineNumber;
}

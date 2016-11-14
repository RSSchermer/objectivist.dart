part of obj_statements;

/// Specifies the shadow object filename.
///
/// A shadow object is used to cast shadows for the current object. The shadow
/// object is invisible except for its shadow.
///
/// An object should cast shadows only if it has a shadow object. You can use an
/// object as its own shadow object. However, a simplified version of the
/// original object is usually preferable for shadow objects, since shadow
/// casting can greatly increase rendering time.
///
/// Only one shadow object can be specified in a object file. If more than one
/// shadow object is specified, then the last one specified should be used.
class ShadowObjStatement implements ObjStatement {
  /// The filename for the shadow object.
  ///
  /// Any valid object filename can be used for the shadow object. The object
  /// file can be an `.obj` or `.mod` file. If a filename is given without an
  /// extension, then an extension of `.obj` should be assumed.
  final String filename;

  final int lineNumber;

  /// Instantiates a new [ShadowObjStatement].
  ShadowObjStatement(this.filename, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitShadowObjStatement(this);
  }

  String toSource() => 'shadow_obj $filename';

  String toString() => 'ShadowObjStatement($filename, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is ShadowObjStatement &&
          other.filename == filename &&
          other.lineNumber == lineNumber;
}

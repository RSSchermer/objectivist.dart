part of obj_statements;

/// Specifies the trace object filename.
///
/// A trace object is used in generating reflections of the current object on
/// reflective surfaces. The trace object is invisible except for its
/// reflection.
///
/// An object should appear in reflections only if it has a trace object. You
/// can use an object as its own trace object. However, a simplified version of
/// the original object is usually preferable for trace objects, since ray
/// tracing can greatly increase rendering time.
///
/// Only one trace object can be specified in a object file. If more than one
/// trace object is specified, then the last one specified should be used.
class TraceObjStatement implements ObjStatement {
  /// The filename for the trace object.
  ///
  /// Any valid object filename can be used for the trace object. The object
  /// file can be an `.obj` or `.mod` file. If a filename is given without an
  /// extension, then an extension of `.obj` should be assumed.
  final String filename;

  final int lineNumber;

  /// Instantiates a new [TraceObjStatement].
  TraceObjStatement(this.filename, {this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitTraceObjStatement(this);
  }

  String toSource() => 'trace_obj $filename';

  String toString() => 'TraceObjStatement($filename, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is TraceObjStatement &&
          other.filename == filename &&
          other.lineNumber == lineNumber;
}

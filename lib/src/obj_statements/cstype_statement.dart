part of obj_statements;

/// Enumerates the different free-form curve and surface types supported by the
/// OBJ specification.
enum CSType { basisMatrix, bezier, bSpline, cardinal, taylor }

/// State setting statement that specifies the type and rationality of any
/// curves and surfaces superseding it.
class CstypeStatement implements ObjStatement {
  /// The curve or surface type set by this [CstypeStatement].
  final CSType type;

  /// Whether or not superseding curves and statements are rational or not.
  final bool isRational;

  final int lineNumber;

  /// Instantiates a new [CstypeStatement].
  CstypeStatement(this.type, {this.isRational: false, this.lineNumber});

  void acceptVisit(ObjStatementVisitor visitor) {
    visitor.visitCstypeStatement(this);
  }

  String toSource() {
    final typeString = _csTypeStringMapping[type];

    if (isRational) {
      return 'cstype rat $typeString';
    } else {
      return 'cstype $typeString';
    }
  }

  String toString() => 'CSTypeStatement($type, isRational: $isRational, '
      'lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CstypeStatement &&
          other.type == type &&
          other.isRational == isRational &&
          other.lineNumber == lineNumber;
}

const _csTypeStringMapping = const {
  CSType.basisMatrix: 'bmatrix',
  CSType.bezier: 'bezier',
  CSType.bSpline: 'bspline',
  CSType.cardinal: 'cardinal',
  CSType.taylor: 'taylor'
};

part of obj_reading.statement_builders;

class CstypeStatementBuilder implements ObjStatementBuilder {
  final Uri sourceUri;

  final int lineNumber;

  CSType _type;

  bool _isRational = false;

  int _argumentCount = 0;

  List<ObjReadingError> _errors = [];

  CstypeStatementBuilder(this.sourceUri, this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        switch (argument) {
          case 'rat':
            _isRational = true;
            break;
          case 'bmatrix':
            _type = CSType.basisMatrix;
            break;
          case 'bezier':
            _type = CSType.bezier;
            break;
          case 'bspline':
            _type = CSType.bSpline;
            break;
          case 'cardinal':
            _type = CSType.cardinal;
            break;
          case 'taylor':
            _type = CSType.taylor;
            break;
          default:
            _errors.add(new ObjReadingError(
                sourceUri,
                lineNumber,
                'The first argument to a `cstype` statement must be either '
                '`rat`, `bmatrix`, `bezier`, `bspline`, `cardinal` or '
                '`taylor`.'));
        }
      } else if (_argumentCount == 1) {
        if (_isRational) {
          switch (argument) {
            case 'bmatrix':
              _type = CSType.basisMatrix;
              break;
            case 'bezier':
              _type = CSType.bezier;
              break;
            case 'bspline':
              _type = CSType.bSpline;
              break;
            case 'cardinal':
              _type = CSType.cardinal;
              break;
            case 'taylor':
              _type = CSType.taylor;
              break;
            default:
              _errors.add(new ObjReadingError(
                  sourceUri,
                  lineNumber,
                  'The second argument to a `cstype` statement must be either '
                  '`bmatrix`, `bezier`, `bspline`, `cardinal` or `taylor`.'));
          }
        } else {
          _errors.add(new ObjReadingError(
              sourceUri,
              lineNumber,
              'A `cstype` statement only takes a second argument if the first '
              'argument was `rat`.'));
        }
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          sourceUri, lineNumber, 'cstype', _argumentCount, 'int', ['String']));
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'cstype',
          _argumentCount, 'IntPair', ['String']));
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'cstype',
          _argumentCount, 'IntTriple', ['String']));
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(sourceUri, lineNumber, 'cstype',
          _argumentCount, 'double', ['String']));
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_isRational && _argumentCount < 2) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `cstype` statement declared as `rat` requires a second argument.'));
    } else if (!_isRational && _argumentCount < 1) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `cstype` statement requires at least 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new ObjStatementResult._success(new CstypeStatement(_type,
          isRational: _isRational, lineNumber: lineNumber));
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 2) {
      _errors.add(new ObjReadingError(sourceUri, lineNumber,
          'A `cstype` statement does not take more than 2 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

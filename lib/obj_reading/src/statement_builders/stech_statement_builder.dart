part of obj_reading.statement_builders;

enum _StechStatementBuilderMode { cparma, cparmb, cspace, curv }

class StechStatementBuilder implements ObjStatementBuilder {
  _StechStatementBuilderMode _mode;

  double _cparmaResolutionU;

  double _cparmaResolutionV;

  double _cparmbResolution;

  double _cspaceMaxLength;

  double _curvMaxDistance;

  double _curvMaxAngle;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjReadingError> _errors = [];

  StechStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        switch (argument) {
          case 'cparma':
            _mode = _StechStatementBuilderMode.cparma;
            break;
          case 'cparmb':
            _mode = _StechStatementBuilderMode.cparmb;
            break;
          case 'cspace':
            _mode = _StechStatementBuilderMode.cspace;
            break;
          case 'curv':
            _mode = _StechStatementBuilderMode.curv;
            break;
          default:
            _errors.add(new ObjReadingError(
                lineNumber,
                'The first argument to a `stech` statement must be either '
                '`cparma`, `cparmb`, `cspace` or `curv`.'));
        }
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'stech', _argumentCount, 'String', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'stech', _argumentCount, 'int', ['String']));
      } else if (_argumentCount == 1) {
        if (_mode == _StechStatementBuilderMode.cparma) {
          _cparmaResolutionU = argument.toDouble();
        } else if (_mode == _StechStatementBuilderMode.cparmb) {
          _cparmbResolution = argument.toDouble();
        } else if (_mode == _StechStatementBuilderMode.cspace) {
          _cspaceMaxLength = argument.toDouble();
        } else if (_mode == _StechStatementBuilderMode.curv) {
          _curvMaxDistance = argument.toDouble();
        }
      } else if (_argumentCount == 2) {
        if (_mode == _StechStatementBuilderMode.cparma) {
          _cparmaResolutionV = argument.toDouble();
        } else if (_mode == _StechStatementBuilderMode.curv) {
          _curvMaxAngle = argument.toDouble();
        }
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'stech', _argumentCount, 'IntPair', ['String']));
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'stech', _argumentCount, 'IntPair', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'stech', _argumentCount, 'IntTriple', ['String']));
      } else {
        _errors.add(new ArgumentTypeError(lineNumber, 'stech', _argumentCount,
            'IntTriple', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'stech', _argumentCount, 'double', ['String']));
      } else if (_argumentCount == 1) {
        if (_mode == _StechStatementBuilderMode.cparma) {
          _cparmaResolutionU = argument;
        } else if (_mode == _StechStatementBuilderMode.cparmb) {
          _cparmbResolution = argument;
        } else if (_mode == _StechStatementBuilderMode.cspace) {
          _cspaceMaxLength = argument;
        } else if (_mode == _StechStatementBuilderMode.curv) {
          _curvMaxDistance = argument;
        }
      } else if (_argumentCount == 2) {
        if (_mode == _StechStatementBuilderMode.cparma) {
          _cparmaResolutionV = argument;
        } else if (_mode == _StechStatementBuilderMode.curv) {
          _curvMaxAngle = argument;
        }
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if ((_mode == _StechStatementBuilderMode.cparma ||
            _mode == _StechStatementBuilderMode.curv) &&
        _argumentCount < 3) {
      _errors.add(new ObjReadingError(
          lineNumber,
          'A `stech` statement declared as `cparma` or `curv` requires 2 '
          'additional arguments.'));
    } else if ((_mode == _StechStatementBuilderMode.cparmb ||
            _mode == _StechStatementBuilderMode.cspace ||
            _mode == null) &&
        _argumentCount < 2) {
      _errors.add(new ObjReadingError(
          lineNumber, 'A `stech` statement requires at least 2 arguments.'));
    }

    if (_errors.isEmpty) {
      if (_mode == _StechStatementBuilderMode.cparma) {
        final technique = new SurfaceConstantParametricSubdivisionA(
            _cparmaResolutionU, _cparmaResolutionV);

        return new ObjStatementResult._success(
            new StechStatement(technique, lineNumber: lineNumber));
      } else if (_mode == _StechStatementBuilderMode.cparmb) {
        final technique =
            new SurfaceConstantParametricSubdivisionB(_cparmbResolution);

        return new ObjStatementResult._success(
            new StechStatement(technique, lineNumber: lineNumber));
      } else if (_mode == _StechStatementBuilderMode.cspace) {
        final technique =
            new SurfaceConstantSpatialSubdivision(_cspaceMaxLength);

        return new ObjStatementResult._success(
            new StechStatement(technique, lineNumber: lineNumber));
      } else if (_mode == _StechStatementBuilderMode.curv) {
        final technique = new SurfaceCurvatureDependentSubdivision(
            _curvMaxDistance, _curvMaxAngle);

        return new ObjStatementResult._success(
            new StechStatement(technique, lineNumber: lineNumber));
      } else {
        return new ObjStatementResult._failure(_errors
          ..add(new ObjReadingError(
              lineNumber,
              'Invalid mode for `stech` statement; mode must be `cparm`, '
              '`cspace` or `curv`.')));
      }
    } else {
      return new ObjStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 3) {
      _errors.add(new ObjReadingError(lineNumber,
          'An `stech` statement does not take more than 3 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

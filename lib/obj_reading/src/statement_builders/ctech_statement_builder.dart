part of obj_reading.statement_builders;

enum _CtechStatementBuilderMode { cparm, cspace, curv }

class CtechStatementBuilder implements ObjStatementBuilder {
  _CtechStatementBuilderMode _mode;

  double _cparmResolution;

  double _cspaceMaxLength;

  double _curvMaxDistance;

  double _curvMaxAngle;

  int _argumentCount = 0;

  final int lineNumber;

  List<ObjError> _errors = [];

  CtechStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        switch (argument) {
          case 'cparm':
            _mode = _CtechStatementBuilderMode.cparm;
            break;
          case 'cspace':
            _mode = _CtechStatementBuilderMode.cspace;
            break;
          case 'curv':
            _mode = _CtechStatementBuilderMode.curv;
            break;
          default:
            _errors.add(new ObjError(
                lineNumber,
                'The first argument to a `ctech` statement must be either '
                '`cparm`, `cspace` or `curv`.'));
        }
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'String', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'int', ['String']));
      } else if (_argumentCount == 1) {
        if (_mode == _CtechStatementBuilderMode.cparm) {
          _cparmResolution = argument.toDouble();
        } else if (_mode == _CtechStatementBuilderMode.cspace) {
          _cspaceMaxLength = argument.toDouble();
        } else if (_mode == _CtechStatementBuilderMode.curv) {
          _curvMaxDistance = argument.toDouble();
        }
      } else if (_argumentCount == 2) {
        _curvMaxAngle = argument.toDouble();
      }
    }

    _argumentCount++;
  }

  void addIntPairArgument(IntPair argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'IntPair', ['String']));
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'IntPair', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addIntTripleArgument(IntTriple argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'IntTriple', ['String']));
      } else {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'IntTriple', ['int', 'double']));
      }
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      if (_argumentCount == 0) {
        _errors.add(new ArgumentTypeError(
            lineNumber, 'ctech', _argumentCount, 'double', ['String']));
      } else if (_argumentCount == 1) {
        if (_mode == _CtechStatementBuilderMode.cparm) {
          _cparmResolution = argument;
        } else if (_mode == _CtechStatementBuilderMode.cspace) {
          _cspaceMaxLength = argument;
        } else if (_mode == _CtechStatementBuilderMode.curv) {
          _curvMaxDistance = argument;
        }
      } else if (_argumentCount == 2) {
        _curvMaxAngle = argument;
      }
    }

    _argumentCount++;
  }

  ObjStatementResult build() {
    if (_mode == _CtechStatementBuilderMode.curv && _argumentCount < 3) {
      _errors.add(new ObjError(
          lineNumber,
          'A `ctech` statement declared as `curv` requires 2 additional '
          'arguments.'));
    } else if ((_mode == _CtechStatementBuilderMode.cparm ||
            _mode == _CtechStatementBuilderMode.cspace ||
            _mode == null) &&
        _argumentCount < 2) {
      _errors.add(new ObjError(
          lineNumber, 'A `ctech` statement requires at least 2 arguments.'));
    }

    if (_errors.isEmpty) {
      if (_mode == _CtechStatementBuilderMode.cparm) {
        final technique =
            new CurveConstantParametricSubdivision(_cparmResolution);

        return new ObjStatementResult.success(
            new CtechStatement(technique, lineNumber: lineNumber));
      } else if (_mode == _CtechStatementBuilderMode.cspace) {
        final technique = new CurveConstantSpatialSubdivision(_cspaceMaxLength);

        return new ObjStatementResult.success(
            new CtechStatement(technique, lineNumber: lineNumber));
      } else if (_mode == _CtechStatementBuilderMode.curv) {
        final technique = new CurveCurvatureDependentSubdivision(
            _curvMaxDistance, _curvMaxAngle);

        return new ObjStatementResult.success(
            new CtechStatement(technique, lineNumber: lineNumber));
      } else {
        return new ObjStatementResult.failure(_errors
          ..add(new ObjError(
              lineNumber,
              'Invalid mode for a `ctech` statement; mode must be `cparm`, '
              '`cspace` or `curv`.')));
      }
    } else {
      return new ObjStatementResult.failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 3) {
      _errors.add(new ObjError(lineNumber,
          'A `ctech` statement does not take more than 3 arguments.'));

      return false;
    } else {
      return true;
    }
  }
}

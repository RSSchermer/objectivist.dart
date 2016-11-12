part of obj_reading;

class ObjStatementizer {
  int _lineNumber = 0;

  ObjStatementBuilder _statementBuilder;

  ObjToken _lastToken;

  List<ObjStatement> _statements;

  List<ObjError> _errors;

  void process(ObjToken token) {
    if (token.type == ObjTokenType.newline) {
      _lineNumber++;
    }

    if (_statementBuilder == null) {
      switch (token.type) {
        case ObjTokenType.comment:
        case ObjTokenType.newline:
          break;
        case ObjTokenType.string:
          switch (token.value) {
            case 'v':
              _statementBuilder = new VStatementBuilder(_lineNumber);
              break;
            case 'vt':
              _statementBuilder = new VtStatementBuilder(_lineNumber);
              break;
            case 'vn':
              _statementBuilder = new VnStatementBuilder(_lineNumber);
              break;
            case 'vp':
              _statementBuilder = new VpStatementBuilder(_lineNumber);
              break;
            case 'cstype':
              _statementBuilder = new CstypeStatementBuilder(_lineNumber);
              break;
            case 'deg':
              _statementBuilder = new DegStatementBuilder(_lineNumber);
              break;
            case 'bmat':
              _statementBuilder = new BmatStatementBuilder(_lineNumber);
              break;
            case 'step':
              _statementBuilder = new StepStatementBuilder(_lineNumber);
              break;
            case 'p':
              _statementBuilder = new PStatementBuilder(_lineNumber);
              break;
            case 'l':
              _statementBuilder = new LStatementBuilder(_lineNumber);
              break;
            case 'f':
              _statementBuilder = new FStatementBuilder(_lineNumber);
              break;
            case 'curv':
              _statementBuilder = new CurvStatementBuilder(_lineNumber);
              break;
            case 'curv2':
              _statementBuilder = new Curv2StatementBuilder(_lineNumber);
              break;
            case 'surf':
              _statementBuilder = new SurfStatementBuilder(_lineNumber);
              break;
            case 'parm':
              _statementBuilder = new ParmStatementBuilder(_lineNumber);
              break;
            case 'trim':
              _statementBuilder = new TrimStatementBuilder(_lineNumber);
              break;
            case 'hole':
              _statementBuilder = new HoleStatementBuilder(_lineNumber);
              break;
            case 'scrv':
              _statementBuilder = new ScrvStatementBuilder(_lineNumber);
              break;
            case 'sp':
              _statementBuilder = new SpStatementBuilder(_lineNumber);
              break;
            case 'end':
              _statementBuilder = new EndStatementBuilder(_lineNumber);
              break;
            case 'con':
              _statementBuilder = new ConStatementBuilder(_lineNumber);
              break;
            case 'g':
              _statementBuilder = new GStatementBuilder(_lineNumber);
              break;
            case 's':
              _statementBuilder = new SStatementBuilder(_lineNumber);
              break;
            case 'mg':
              _statementBuilder = new MgStatementBuilder(_lineNumber);
              break;
            case 'o':
              _statementBuilder = new OStatementBuilder(_lineNumber);
              break;
            case 'bevel':
              _statementBuilder = new BevelStatementBuilder(_lineNumber);
              break;
            case 'c_interp':
              _statementBuilder = new CInterpStatementBuilder(_lineNumber);
              break;
            case 'd_interp':
              _statementBuilder = new DInterpStatementBuilder(_lineNumber);
              break;
            case 'lod':
              _statementBuilder = new LodStatementBuilder(_lineNumber);
              break;
            case 'maplib':
              _statementBuilder = new MaplibStatementBuilder(_lineNumber);
              break;
            case 'usemap':
              _statementBuilder = new UsemapStatementBuilder(_lineNumber);
              break;
            case 'usemtl':
              _statementBuilder = new UsemtlStatementBuilder(_lineNumber);
              break;
            case 'mtllib':
              _statementBuilder = new MtllibStatementBuilder(_lineNumber);
              break;
            case 'shadow_obj':
              _statementBuilder = new ShadowObjStatementBuilder(_lineNumber);
              break;
            case 'trace_obj':
              _statementBuilder = new TraceObjStatementBuilder(_lineNumber);
              break;
            case 'ctech':
              _statementBuilder = new CtechStatementBuilder(_lineNumber);
              break;
            case 'stech':
              _statementBuilder = new StechStatementBuilder(_lineNumber);
              break;
          }

          break;
        default:
          _errors.add(new ObjError(_lineNumber,
              '${token.value} is not a valid way to start a new statement.'));
      }
    } else {
      if ((token.type == ObjTokenType.newline ||
                  token.type == ObjTokenType.comment) &&
              _lastToken.type != ObjTokenType.backslash ||
          token.type == ObjTokenType.endOfText) {
        final result = _statementBuilder.build();

        if (result.statement != null) {
          _statements.add(result.statement);
        } else {
          _errors.addAll(result.errors);
        }

        _statementBuilder = null;
      } else {
        switch (token.type) {
          case ObjTokenType.string:
            _statementBuilder.addStringArgument(token.value);
            break;
          case ObjTokenType.int:
            _statementBuilder.addIntArgument(int.parse(token.value));
            break;
          case ObjTokenType.intPair:
            _statementBuilder.addIntPairArgument(IntPair.parse(token.value));
            break;
          case ObjTokenType.intTriple:
            _statementBuilder
                .addIntTripleArgument(IntTriple.parse(token.value));
            break;
          case ObjTokenType.double:
            _statementBuilder.addDoubleArgument(double.parse(token.value));
            break;
          default:
        }
      }
    }

    _lastToken = token;
  }

  StatementizerResults flush() =>
      new StatementizerResults(_statements, _errors);

  StatementizerResults clean() {
    _statementBuilder = null;
    _lastToken = null;
    _lineNumber = 0;

    return new StatementizerResults(_statements, _errors);
  }
}

class IntPair {
  static IntPair parse(String string) {
    final parts = string.split('/');

    return new IntPair(int.parse(parts[0]), int.parse(parts[1]));
  }

  final int value1;

  final int value2;

  IntPair(this.value1, this.value2);
}

class IntTriple {
  static IntTriple parse(String string) {
    final parts = string.split('/');
    final value1 = int.parse(parts[0]);
    final value2 = parts[1] != '' ? int.parse(parts[1]) : null;
    final value3 = int.parse(parts[2]);

    return new IntTriple(value1, value2, value3);
  }

  final int value1;

  final int value2;

  final int value3;

  IntTriple(this.value1, this.value2, this.value3);
}

class StatementizerResults extends DelegatingIterable<ObjStatement> {
  final Iterable<ObjStatement> delegate;

  final Iterable<ObjError> errors;

  Iterable<ObjStatement> get statements => delegate;

  StatementizerResults(this.delegate, this.errors);
}

class ObjStatementizerTransformer
    implements StreamTransformer<Iterable<ObjToken>, StatementizerResults> {
  final ObjStatementizer statementizer;

  ObjStatementizerTransformer(this.statementizer);

  Stream<StatementizerResults> bind(Stream<Iterable<ObjToken>> stream) {
    final outStreamController = new StreamController<StatementizerResults>();

    stream.listen((tokens) {
      for (var token in tokens) {
        statementizer.process(token);
      }

      outStreamController.add(statementizer.flush());
    });

    return outStreamController.stream;
  }
}

class ObjError {
  final int lineNumber;

  final String description;

  ObjError(this.lineNumber, this.description);

  String toString() => 'Error on line $lineNumber: $description';
}

class ArgumentTypeError implements ObjError {
  final int lineNumber;

  final String statementType;

  final int argumentPosition;

  final String actualType;

  final Iterable<String> expectedTypes;

  ArgumentTypeError(this.lineNumber, this.statementType, this.argumentPosition,
      this.actualType, this.expectedTypes);

  String get description {
    final positionString = _positionToString(argumentPosition);
    final expectedList = expectedTypes.toList();

    var expectedString = expectedList[0];

    for (var i = 1; i < expectedList.length; i++) {
      if (i == expectedTypes.length - 1) {
        expectedString += ' or ${expectedList[i]}';
      } else {
        expectedString += ', ${expectedList[i]}';
      }
    }

    return 'The $positionString argument of a(n) `$statementType` statement '
        'must be a(n) $expectedString; $actualType given.';
  }

  String toString() => 'Error on line $lineNumber: $description';
}

class ObjStatementResult {
  final ObjStatement statement;

  final Iterable<ObjError> errors;

  ObjStatementResult.success(this.statement) : errors = [];

  ObjStatementResult.failure(this.errors) : statement = null;

  bool get isSuccess => statement != null;

  bool get isFailure => !isSuccess;
}

abstract class ObjStatementBuilder {
  void addStringArgument(String argument);

  void addIntArgument(int argument);

  void addIntPairArgument(IntPair argument);

  void addIntTripleArgument(IntTriple argument);

  void addDoubleArgument(double argument);

  ObjStatementResult build();
}

String _positionToString(int position) {
  final adjusted = position + 1;

  switch (adjusted % 10) {
    case 1:
      return '${adjusted}st';
    case 2:
      return '${adjusted}nd';
    default:
      return '${adjusted}th';
  }
}

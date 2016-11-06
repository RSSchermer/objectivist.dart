part of obj_reading;

class ObjReader {
  Future<Obj> readByteStream(Stream<Iterable<int>> byteStream) {
    final lexerTransformer = new ObjLexerTransformer(new ObjLexer());
    final statementizerTransformer =
        new ObjStatementizerTransformer(new ObjStatementizer());
    final builder = new StatementVisitingObjBuilder();

    final statementStream = byteStream
        .transform(lexerTransformer)
        .transform(statementizerTransformer);

    return statementStream.forEach((statements) {
      for (var statement in statements) {
        statement.acceptVisit(builder);
      }
    }).then((_) => builder.build());
  }
}

class StatementVisitingObjBuilder implements ObjStatementVisitor {
  Obj build() {}

  void clear() {}

  void visitVStatement(VStatement statement) {}

  void visitVtStatement(VtStatement statement) {}

  void visitVnStatement(VnStatement statement) {}

  void visitVpStatement(VpStatement statement) {}

  void visitCstypeStatement(CstypeStatement statement) {}

  void visitDegStatement(DegStatement statement) {}

  void visitBmatStatement(BmatStatement statement) {}

  void visitStepStatement(StepStatement statement) {}

  void visitPStatement(PStatement statement) {}

  void visitLStatement(LStatement statement) {}

  void visitFStatement(FStatement statement) {}

  void visitCurvStatement(CurvStatement statement) {}

  void visitCurv2Statement(Curv2Statement statement) {}

  void visitSurfStatement(SurfStatement statement) {}

  void visitParmStatement(ParmStatement statement) {}

  void visitTrimStatement(TrimStatement statement) {}

  void visitHoleStatement(HoleStatement statement) {}

  void visitScrvStatement(ScrvStatement statement) {}

  void visitSpStatement(SpStatement statement) {}

  void visitEndStatement(EndStatement statement) {}

  void visitConStatement(ConStatement statement) {}

  void visitGStatement(GStatement statement) {}

  void visitSStatement(SStatement statement) {}

  void visitMgStatement(MgStatement statement) {}

  void visitOStatement(OStatement statement) {}

  void visitBevelStatement(BevelStatement statement) {}

  void visitCInterpStatement(CInterpStatement statement) {}

  void visitDInterpStatement(DInterpStatement statement) {}

  void visitLodStatement(LodStatement statement) {}

  void visitMaplibStatement(MaplibStatement statement) {}

  void visitUsemapStatement(UsemapStatement statement) {}

  void visitUsemtlStatement(UsemtlStatement statement) {}

  void visitMtllibStatement(MtllibStatement statement) {}

  void visitShadowObjStatement(ShadowObjStatement statement) {}

  void visitTraceObjStatement(TraceObjStatement statement) {}

  void visitCtechStatement(CtechStatement statement) {}

  void visitStechStatement(StechStatement statement) {}
}

class ObjLexerTransformer
    implements StreamTransformer<Iterable<int>, Iterable<ObjToken>> {
  final ObjLexer lexer;

  ObjLexerTransformer(this.lexer);

  Stream<Iterable<ObjToken>> bind(Stream<Iterable<int>> stream) {
    final outStreamController = new StreamController<Iterable<ObjToken>>();

    stream.listen((charCodes) {
      for (var charCode in charCodes) {
        lexer.process(charCode);
      }

      outStreamController.add(lexer.flush());
    });

    return outStreamController.stream;
  }
}

class ObjStatementizerTransformer
    implements StreamTransformer<Iterable<ObjToken>, Iterable<ObjStatement>> {
  final ObjStatementizer statementizer;

  ObjStatementizerTransformer(this.statementizer);

  Stream<Iterable<ObjStatement>> bind(Stream<Iterable<ObjToken>> stream) {
    final outStreamController = new StreamController<Iterable<ObjStatement>>();

    stream.listen((tokens) {
      for (var token in tokens) {
        statementizer.process(token);
      }

      outStreamController.add(statementizer.flush());
    });

    return outStreamController.stream;
  }
}

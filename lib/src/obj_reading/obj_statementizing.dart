part of obj_reading;

class ObjStatementizer {

  void process(ObjToken token) {

  }

  Iterable<ObjStatement> flush() {

  }

  Iterable<ObjStatement> clean() {

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

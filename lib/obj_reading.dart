library obj_reading;

import 'dart:async';

import 'package:resource/resource.dart';

import 'obj_reading/lexing.dart';
import 'obj_reading/statementizing.dart';

ObjStatementizerResults statementizeObj(String source, Uri sourceUri) {
  final lexer = new ObjLexer();
  final statementizer = new ObjStatementizer(sourceUri);

  for (var i = 0; i < source.length; i++) {
    lexer.process(source.codeUnitAt(i));
  }

  lexer.process(3); // Signal "end of text"

  for (var token in lexer.flush()) {
    statementizer.process(token);
  }

  return statementizer.flush();
}

Future<ObjStatementizerResults> statementizeObjResource(Resource resource) {
  return resource
      .readAsString()
      .then((source) => statementizeObj(source, resource.uri));
}

Stream<ObjStatementizerResults> statementizeObjResourceStreamed(
    Resource resource) {
  final lexer = new ObjLexer();
  final statementizer = new ObjStatementizer(resource.uri);
  final outStreamController = new StreamController<ObjStatementizerResults>();

  resource.openRead().forEach((chunk) {
    for (var i = 0; i < chunk.length; i++) {
      lexer.process(chunk[i]);
    }

    for (var token in lexer.flush()) {
      statementizer.process(token);
    }

    outStreamController.add(statementizer.flush());
  }).whenComplete(() {
    lexer.process(3); // Signal "end of text"

    for (var token in lexer.flush()) {
      statementizer.process(token);
    }

    outStreamController.add(statementizer.flush());
    outStreamController.close();
  });

  return outStreamController.stream;
}

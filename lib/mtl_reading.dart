library mtl_reading;

import 'dart:async';

import 'package:resource/resource.dart';

import 'mtl_reading/lexing.dart';
import 'mtl_reading/statementizing.dart';

MtlStatementizerResults statementizeMtl(String source, Uri sourceUri) {
  final lexer = new MtlLexer();
  final statementizer = new MtlStatementizer(sourceUri);

  for (var i = 0; i < source.length; i++) {
    lexer.process(source.codeUnitAt(i));
  }

  lexer.process(3); // Signal "end of text"

  for (var token in lexer.flush()) {
    statementizer.process(token);
  }

  return statementizer.flush();
}

Future<MtlStatementizerResults> statementizeMtlResource(Resource resource) {
  return resource
      .readAsString()
      .then((source) => statementizeMtl(source, resource.uri));
}

Stream<MtlStatementizerResults> statementizeMtlResourceStreamed(
    Resource resource) {
  final lexer = new MtlLexer();
  final statementizer = new MtlStatementizer(resource.uri);
  final outStreamController = new StreamController<MtlStatementizerResults>();

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

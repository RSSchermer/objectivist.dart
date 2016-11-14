library obj_reading;

import 'dart:async';

import 'package:quiver/collection.dart';
import 'package:resource/resource.dart';

import 'obj_statements.dart';

part 'src/obj_reading/obj_lexing.dart';
part 'src/obj_reading/obj_statementizing.dart';

StatementizerResults statementize(String source) {
  final lexer = new ObjLexer();
  final statementizer = new ObjStatementizer();

  for (var i = 0; i < source.length; i++) {
    lexer.process(source.codeUnitAt(i));
  }

  lexer.process(3); // Signal "end of text"

  for (var token in lexer.flush()) {
    statementizer.process(token);
  }

  return statementizer.flush();
}

Future<StatementizerResults> statementizeResource(Resource resource) {
  return resource.readAsString().then((source) => statementize(source));
}

Stream<StatementizerResults> statementizeResourceStreamed(Resource resource) {
  final lexer = new ObjLexer();
  final statementizer = new ObjStatementizer();
  final outStreamController = new StreamController<StatementizerResults>();

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

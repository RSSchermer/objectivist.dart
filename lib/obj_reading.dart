library obj_reading;

import 'dart:async';

import 'package:quiver/collection.dart';
import 'package:resource/resource.dart';

import 'obj_statements.dart';

part 'src/obj_reading/obj_lexing.dart';
part 'src/obj_reading/obj_statementizing.dart';

part 'src/obj_reading/v_statement_builder.dart';
part 'src/obj_reading/vt_statement_builder.dart';
part 'src/obj_reading/vn_statement_builder.dart';
part 'src/obj_reading/vp_statement_builder.dart';
part 'src/obj_reading/cstype_statement_builder.dart';
part 'src/obj_reading/deg_statement_builder.dart';
part 'src/obj_reading/bmat_statement_builder.dart';
part 'src/obj_reading/step_statement_builder.dart';
part 'src/obj_reading/p_statement_builder.dart';
part 'src/obj_reading/l_statement_builder.dart';
part 'src/obj_reading/f_statement_builder.dart';
part 'src/obj_reading/curv_statement_builder.dart';
part 'src/obj_reading/curv2_statement_builder.dart';
part 'src/obj_reading/surf_statement_builder.dart';
part 'src/obj_reading/parm_statement_builder.dart';
part 'src/obj_reading/trim_statement_builder.dart';
part 'src/obj_reading/hole_statement_builder.dart';
part 'src/obj_reading/scrv_statement_builder.dart';
part 'src/obj_reading/sp_statement_builder.dart';
part 'src/obj_reading/end_statement_builder.dart';
part 'src/obj_reading/con_statement_builder.dart';
part 'src/obj_reading/g_statement_builder.dart';
part 'src/obj_reading/s_statement_builder.dart';
part 'src/obj_reading/mg_statement_builder.dart';
part 'src/obj_reading/o_statement_builder.dart';
part 'src/obj_reading/bevel_statement_builder.dart';
part 'src/obj_reading/c_interp_statement_builder.dart';
part 'src/obj_reading/d_interp_statement_builder.dart';
part 'src/obj_reading/lod_statement_builder.dart';
part 'src/obj_reading/maplib_statement_builder.dart';
part 'src/obj_reading/usemap_statement_builder.dart';
part 'src/obj_reading/usemtl_statement_builder.dart';
part 'src/obj_reading/mtllib_statement_builder.dart';
part 'src/obj_reading/shadow_obj_statement_builder.dart';
part 'src/obj_reading/trace_obj_statement_builder.dart';
part 'src/obj_reading/ctech_statement_builder.dart';
part 'src/obj_reading/stech_statement_builder.dart';

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

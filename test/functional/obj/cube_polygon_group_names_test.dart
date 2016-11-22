import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/cube_polygon_group_names.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/cube_polygon_group_names.obj');
    final results = await statementizeObjResource(resource);

    expect(results.statements, equals([
      new VStatement(0.0, 2.0, 2.0, null, lineNumber: 6),
      new VStatement(0.0, 0.0, 2.0, null, lineNumber: 7),
      new VStatement(2.0, 0.0, 2.0, null, lineNumber: 8),
      new VStatement(2.0, 2.0, 2.0, null, lineNumber: 9),
      new VStatement(0.0, 2.0, 0.0, null, lineNumber: 10),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 11),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 12),
      new VStatement(2.0, 2.0, 0.0, null, lineNumber: 13),
      new GStatement(['front', 'cube'], lineNumber: 16),
      new FStatement([
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
        new VertexNumTriple(4)
      ], lineNumber: 17),
      new GStatement(['back', 'cube'], lineNumber: 18),
      new FStatement([
        new VertexNumTriple(8),
        new VertexNumTriple(7),
        new VertexNumTriple(6),
        new VertexNumTriple(5)
      ], lineNumber: 19),
      new GStatement(['right', 'cube'], lineNumber: 20),
      new FStatement([
        new VertexNumTriple(4),
        new VertexNumTriple(3),
        new VertexNumTriple(7),
        new VertexNumTriple(8)
      ], lineNumber: 21),
      new GStatement(['top', 'cube'], lineNumber: 22),
      new FStatement([
        new VertexNumTriple(5),
        new VertexNumTriple(1),
        new VertexNumTriple(4),
        new VertexNumTriple(8)
      ], lineNumber: 23),
      new GStatement(['left', 'cube'], lineNumber: 24),
      new FStatement([
        new VertexNumTriple(5),
        new VertexNumTriple(6),
        new VertexNumTriple(2),
        new VertexNumTriple(1)
      ], lineNumber: 25),
      new GStatement(['bottom', 'cube'], lineNumber: 26),
      new FStatement([
        new VertexNumTriple(2),
        new VertexNumTriple(6),
        new VertexNumTriple(7),
        new VertexNumTriple(3)
      ], lineNumber: 27),
    ]));

    expect(results.errors, isEmpty);
  });
}

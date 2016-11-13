import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/cube_polygon.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/cube_polygon.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VStatement(0.0, 2.0, 2.0, null, lineNumber: 5),
      new VStatement(0.0, 0.0, 2.0, null, lineNumber: 6),
      new VStatement(2.0, 0.0, 2.0, null, lineNumber: 7),
      new VStatement(2.0, 2.0, 2.0, null, lineNumber: 8),
      new VStatement(0.0, 2.0, 0.0, null, lineNumber: 9),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 10),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 11),
      new VStatement(2.0, 2.0, 0.0, null, lineNumber: 12),
      new FStatement([
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
        new VertexNumTriple(4)
      ], lineNumber: 13),
      new FStatement([
        new VertexNumTriple(8),
        new VertexNumTriple(7),
        new VertexNumTriple(6),
        new VertexNumTriple(5)
      ], lineNumber: 14),
      new FStatement([
        new VertexNumTriple(4),
        new VertexNumTriple(3),
        new VertexNumTriple(7),
        new VertexNumTriple(8)
      ], lineNumber: 15),
      new FStatement([
        new VertexNumTriple(5),
        new VertexNumTriple(1),
        new VertexNumTriple(4),
        new VertexNumTriple(8)
      ], lineNumber: 16),
      new FStatement([
        new VertexNumTriple(5),
        new VertexNumTriple(6),
        new VertexNumTriple(2),
        new VertexNumTriple(1)
      ], lineNumber: 17),
      new FStatement([
        new VertexNumTriple(2),
        new VertexNumTriple(6),
        new VertexNumTriple(7),
        new VertexNumTriple(3)
      ], lineNumber: 18),
    ]));

    expect(results.errors, isEmpty);
  });
}

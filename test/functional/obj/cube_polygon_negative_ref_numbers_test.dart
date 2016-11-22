import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/cube_polygon_negative_ref_numbers.obj results in the correct statements without errors', () async {
    final resource =
        new Resource('test/functional/obj/examples/cube_polygon_negative_ref_numbers.obj');
    final results = await statementizeObjResource(resource);

    expect(results.statements, equals([
      new VStatement(0.0, 2.0, 2.0, null, lineNumber: 5),
      new VStatement(0.0, 0.0, 2.0, null, lineNumber: 6),
      new VStatement(2.0, 0.0, 2.0, null, lineNumber: 7),
      new VStatement(2.0, 2.0, 2.0, null, lineNumber: 8),
      new FStatement([
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 9),
      new VStatement(2.0, 2.0, 0.0, null, lineNumber: 11),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 12),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 13),
      new VStatement(0.0, 2.0, 0.0, null, lineNumber: 14),
      new FStatement([
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 15),
      new VStatement(2.0, 2.0, 2.0, null, lineNumber: 17),
      new VStatement(2.0, 0.0, 2.0, null, lineNumber: 18),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 19),
      new VStatement(2.0, 2.0, 0.0, null, lineNumber: 20),
      new FStatement([
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 21),
      new VStatement(0.0, 2.0, 0.0, null, lineNumber: 23),
      new VStatement(0.0, 2.0, 2.0, null, lineNumber: 24),
      new VStatement(2.0, 2.0, 2.0, null, lineNumber: 25),
      new VStatement(2.0, 2.0, 0.0, null, lineNumber: 26),
      new FStatement([
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 27),
      new VStatement(0.0, 2.0, 0.0, null, lineNumber: 29),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 30),
      new VStatement(0.0, 0.0, 2.0, null, lineNumber: 31),
      new VStatement(0.0, 2.0, 2.0, null, lineNumber: 32),
      new FStatement([
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 33),
      new VStatement(0.0, 0.0, 2.0, null, lineNumber: 35),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 36),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 37),
      new VStatement(2.0, 0.0, 2.0, null, lineNumber: 38),
      new FStatement([
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 39),
    ]));

    expect(results.errors, isEmpty);
  });
}

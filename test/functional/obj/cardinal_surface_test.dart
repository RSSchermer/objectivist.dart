import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/cardinal_surface.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/cardinal_surface.obj');
    final results = await statementizeObjResource(resource);

    expect(results.statements, equals([
      new VStatement(-5.0, -5.0, 0.0, null, lineNumber: 5),
      new VStatement(-5.0, -1.666667, 0.0, null, lineNumber: 6),
      new VStatement(-5.0, 1.666667, 0.0, null, lineNumber: 7),
      new VStatement(-5.0, 5.0, 0.0, null, lineNumber: 8),
      new VStatement(-1.666667, -5.0, 0.0, null, lineNumber: 9),
      new VStatement(-1.666667, -1.666667, 0.0, null, lineNumber: 10),
      new VStatement(-1.666667, 1.666667, 0.0, null, lineNumber: 11),
      new VStatement(-1.666667, 5.0, 0.0, null, lineNumber: 12),
      new VStatement(1.666667, -5.0, 0.0, null, lineNumber: 13),
      new VStatement(1.666667, -1.666667, 0.0, null, lineNumber: 14),
      new VStatement(1.666667, 1.666667, 0.0, null, lineNumber: 15),
      new VStatement(1.666667, 5.0, 0.0, null, lineNumber: 16),
      new VStatement(5.0, -5.0, 0.0, null, lineNumber: 17),
      new VStatement(5.0, -1.666667, 0.0, null, lineNumber: 18),
      new VStatement(5.0, 1.666667, 0.0, null, lineNumber: 19),
      new VStatement(5.0, 5.0, 0.0, null, lineNumber: 20),
      new CstypeStatement(CSType.cardinal, lineNumber: 23),
      new StechStatement(new SurfaceConstantParametricSubdivisionA(1.0, 1.0), lineNumber: 24),
      new DegStatement(3, 3, lineNumber: 25),
      new SurfStatement(0.0, 1.0, 0.0, 1.0, [
        new VertexNumTriple(13),
        new VertexNumTriple(14),
        new VertexNumTriple(15),
        new VertexNumTriple(16),
        new VertexNumTriple(9),
        new VertexNumTriple(10),
        new VertexNumTriple(11),
        new VertexNumTriple(12),
        new VertexNumTriple(5),
        new VertexNumTriple(6),
        new VertexNumTriple(7),
        new VertexNumTriple(8),
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
        new VertexNumTriple(4)
      ], lineNumber: 26),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0], lineNumber: 28),
      new ParmStatement(ParameterDirection.v, [0.0, 1.0], lineNumber: 29),
      new EndStatement(lineNumber: 30)
    ]));

    expect(results.errors, isEmpty);
  });
}

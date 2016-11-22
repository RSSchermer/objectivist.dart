import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/rational_bspline_surface.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/rational_bspline_surface.obj');
    final results = await statementizeObjResource(resource);

    expect(results.statements, equals([
      new VStatement(-1.3, -1.0, 0.0, null, lineNumber: 7),
      new VStatement(0.1, -1.0, 0.4, 7.6, lineNumber: 8),
      new VStatement(1.4, -1.0, 0.0, 2.3, lineNumber: 9),
      new VStatement(-1.4, 0.0, 0.2, null, lineNumber: 10),
      new VStatement(0.1, 0.0, 0.9, 0.5, lineNumber: 11),
      new VStatement(1.3, 0.0, 0.4, 1.5, lineNumber: 12),
      new VStatement(-1.4, 1.0, 0.0, 2.3, lineNumber: 13),
      new VStatement(0.1, 1.0, 0.3, 6.1, lineNumber: 14),
      new VStatement(1.1, 1.0, 0.0, 3.3, lineNumber: 15),
      new VtStatement(0.0, 0.0, null, lineNumber:16),
      new VtStatement(0.5, 0.0, null, lineNumber:17),
      new VtStatement(1.0, 0.0, null, lineNumber:18),
      new VtStatement(0.0, 0.5, null, lineNumber:19),
      new VtStatement(0.5, 0.5, null, lineNumber:20),
      new VtStatement(1.0, 0.5, null, lineNumber:21),
      new VtStatement(0.0, 1.0, null, lineNumber:22),
      new VtStatement(0.5, 1.0, null, lineNumber:23),
      new VtStatement(1.0, 1.0, null, lineNumber:24),
      new CstypeStatement(CSType.bSpline, isRational: true, lineNumber: 26),
      new DegStatement(2, 2, lineNumber: 27),
      new SurfStatement(0.0, 1.0, 0.0, 1.0, [
        new VertexNumTriple(1, 1),
        new VertexNumTriple(2, 2),
        new VertexNumTriple(3, 3),
        new VertexNumTriple(4, 4),
        new VertexNumTriple(5, 5),
        new VertexNumTriple(6, 6),
        new VertexNumTriple(7, 7),
        new VertexNumTriple(8, 8),
        new VertexNumTriple(9, 9)
      ], lineNumber: 28),
      new ParmStatement(ParameterDirection.u, [0.0, 0.0, 0.0, 1.0, 1.0, 1.0], lineNumber: 30),
      new ParmStatement(ParameterDirection.v, [0.0, 0.0, 0.0, 1.0, 1.0, 1.0], lineNumber: 31),
      new EndStatement(lineNumber: 32)
    ]));

    expect(results.errors, isEmpty);
  });
}

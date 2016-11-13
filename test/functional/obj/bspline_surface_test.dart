import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/bspline_surface.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/bspline_surface.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new GStatement(['bspatch'], lineNumber: 5),
      new VStatement(-5.0, -5.0, -7.808327, null, lineNumber: 6),
      new VStatement(-5.0, -1.666667, -7.808327, null, lineNumber: 7),
      new VStatement(-5.0, 1.666667, -7.808327, null, lineNumber: 8),
      new VStatement(-5.0, 5.0, -7.808327, null, lineNumber: 9),
      new VStatement(-1.666667, -5.0, -7.808327, null, lineNumber: 10),
      new VStatement(-1.666667, -1.666667, 11.977780, null, lineNumber: 11),
      new VStatement(-1.666667, 1.666667, 11.977780, null, lineNumber: 12),
      new VStatement(-1.666667, 5.0, -7.808327, null, lineNumber: 13),
      new VStatement(1.666667, -5.0, -7.808327, null, lineNumber: 14),
      new VStatement(1.666667, -1.666667, 11.977780, null, lineNumber: 15),
      new VStatement(1.666667, 1.666667, 11.977780, null, lineNumber: 16),
      new VStatement(1.666667, 5.0, -7.808327, null, lineNumber: 17),
      new VStatement(5.0, -5.0, -7.808327, null, lineNumber: 18),
      new VStatement(5.0, -1.666667, -7.808327, null, lineNumber: 19),
      new VStatement(5.0, 1.666667, -7.808327, null, lineNumber: 20),
      new VStatement(5.0, 5.0, -7.808327, null, lineNumber: 21),
      new CstypeStatement(CSType.bSpline, lineNumber: 24),
      new StechStatement(new SurfaceCurvatureDependentSubdivision(0.5, 10.0), lineNumber: 25),
      new DegStatement(3, 3, lineNumber: 26),
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
      ], lineNumber: 27),
      new ParmStatement(ParameterDirection.u, [-3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0, 4.0,], lineNumber: 29),
      new ParmStatement(ParameterDirection.v, [-3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0, 4.0,], lineNumber: 31),
      new EndStatement(lineNumber: 33)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/trimmed_nurbs_surface.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/trimmed_nurbs_surface.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VpStatement(-0.675, 1.85, 3.0, lineNumber: 6),
      new VpStatement(0.915, 1.93, null, lineNumber: 7),
      new VpStatement(2.485, 0.47, 2.0, lineNumber: 8),
      new VpStatement(2.485, -1.03, null, lineNumber: 9),
      new VpStatement(1.605, -1.89, 10.7, lineNumber: 10),
      new VpStatement(-0.745, -0.654, 0.5, lineNumber: 11),
      new CstypeStatement(CSType.bezier, isRational: true, lineNumber: 12),
      new DegStatement(3, null, lineNumber: 13),
      new Curv2Statement([-6, -5, -4, -3, -2, -1, -6], lineNumber: 14),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0], lineNumber: 15),
      new EndStatement(lineNumber: 16),
      new VStatement(-1.35, -1.03, 0.0, null, lineNumber: 19),
      new VStatement(0.13, -1.03, 0.432, 7.6, lineNumber: 20),
      new VStatement(1.48, -1.03, 0.0, 2.3, lineNumber: 21),
      new VStatement(-1.46, 0.06, 0.201, null, lineNumber: 22),
      new VStatement(0.12, 0.06, 0.915, 0.5, lineNumber: 23),
      new VStatement(1.38, 0.06, 0.454, 1.5, lineNumber: 24),
      new VStatement(-1.48, 1.03, 0.0, 2.3, lineNumber: 25),
      new VStatement(0.12, 1.03, 0.394, 6.1, lineNumber: 26),
      new VStatement(1.17, 1.03, 0.0, 3.3, lineNumber: 27),
      new CstypeStatement(CSType.bSpline, isRational: true, lineNumber: 28),
      new DegStatement(2, 2, lineNumber: 29),
      new SurfStatement(-1.0, 2.5, -2.0, 2.0, [
        new VertexNumTriple(-9),
        new VertexNumTriple(-8),
        new VertexNumTriple(-7),
        new VertexNumTriple(-6),
        new VertexNumTriple(-5),
        new VertexNumTriple(-4),
        new VertexNumTriple(-3),
        new VertexNumTriple(-2),
        new VertexNumTriple(-1)
      ], lineNumber: 30),
      new ParmStatement(ParameterDirection.u, [-1.0, -1.0, -1.0, 2.5, 2.5, 2.5], lineNumber: 31),
      new ParmStatement(ParameterDirection.v, [-2.0, -2.0, -2.0, -2.0, -2.0, -2.0], lineNumber: 32),
      new TrimStatement([new Curve2Instance(0.0, 2.0, 1)], lineNumber: 33),
      new EndStatement(lineNumber: 34)
    ]));

    expect(results.errors, isEmpty);
  });
}

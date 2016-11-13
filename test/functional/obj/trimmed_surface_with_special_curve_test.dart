import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/trimmed_surface_with_special_curve.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/trimmed_surface_with_special_curve.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VpStatement(-0.675, 1.85, 3.0, lineNumber: 8),
      new VpStatement(0.915, 1.93, null, lineNumber: 9),
      new VpStatement(2.485, 0.47, 2.0, lineNumber: 10),
      new VpStatement(2.485, -1.03, null, lineNumber: 11),
      new VpStatement(1.605, -1.89, 10.7, lineNumber: 12),
      new VpStatement(-0.745, -0.654, 0.5, lineNumber: 13),
      new CstypeStatement(CSType.bezier, isRational: true, lineNumber: 14),
      new DegStatement(3, null, lineNumber: 15),
      new Curv2Statement([-6, -5, -4, -3, -2, -1, -6], lineNumber: 16),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0], lineNumber: 17),
      new EndStatement(lineNumber: 18),
      new VpStatement(-0.185, 0.322, null, lineNumber: 21),
      new VpStatement(0.214, 0.818, null, lineNumber: 22),
      new VpStatement(1.652, 0.207, null, lineNumber: 23),
      new VpStatement(1.652, -0.455, null, lineNumber: 24),
      new Curv2Statement([-4, -3, -2, -1], lineNumber: 25),
      new ParmStatement(ParameterDirection.u, [2.0, 10.0,], lineNumber: 26),
      new EndStatement(lineNumber: 27),
      new VStatement(-1.35, -1.03, 0.0, null, lineNumber: 30),
      new VStatement(0.13, -1.03, 0.432, 7.6, lineNumber: 31),
      new VStatement(1.48, -1.03, 0.0, 2.3, lineNumber: 32),
      new VStatement(-1.46, 0.06, 0.201, null, lineNumber: 33),
      new VStatement(0.12, 0.06, 0.915, 0.5, lineNumber: 34),
      new VStatement(1.38, 0.06, 0.454, 1.5, lineNumber: 35),
      new VStatement(-1.48, 1.03, 0.0, 2.3, lineNumber: 36),
      new VStatement(0.12, 1.03, 0.394, 6.1, lineNumber: 37),
      new VStatement(1.17, 1.03, 0.0, 3.3, lineNumber: 38),
      new CstypeStatement(CSType.bSpline, isRational: true, lineNumber: 39),
      new DegStatement(2, 2, lineNumber: 40),
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
      ], lineNumber: 41),
      new ParmStatement(ParameterDirection.u, [-1.0, -1.0, -1.0, 2.5, 2.5, 2.5], lineNumber: 42),
      new ParmStatement(ParameterDirection.v, [-2.0, -2.0, -2.0, 2.0, 2.0, 2.0], lineNumber: 43),
      new TrimStatement([new Curve2Instance(0.0, 2.0, 1)], lineNumber: 44),
      new ScrvStatement([new Curve2Instance(4.2, 9.7, 2)], lineNumber: 45),
      new EndStatement(lineNumber: 46)
    ]));

    expect(results.errors, isEmpty);
  });
}

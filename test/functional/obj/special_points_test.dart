import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/special_points.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/special_points.obj');
    final results = await statementizeObjResource(resource);

    expect(results.statements, equals([
      new VpStatement(0.5, null, null, lineNumber: 9),
      new VpStatement(0.7, null, null, lineNumber: 10),
      new VpStatement(1.1, null, null, lineNumber: 11),
      new VpStatement(0.2, 0.95, null, lineNumber: 12),
      new VStatement(0.3, 1.5, 0.1, null, lineNumber: 15),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 16),
      new VStatement(1.0, 1.0, 0.0, null, lineNumber: 17),
      new VStatement(2.0, 1.0, 0.0, null, lineNumber: 18),
      new VStatement(3.0, 0.0, 0.0, null, lineNumber: 19),
      new CstypeStatement(CSType.bezier, lineNumber: 20),
      new DegStatement(3, null, lineNumber: 21),
      new CurvStatement(0.2, 0.9, [-4, -3, -2, -1], lineNumber: 22),
      new SpStatement([1], lineNumber: 23),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0], lineNumber: 24),
      new EndStatement(lineNumber: 25),
      new VpStatement(-0.675, 1.850,  3.000, lineNumber: 28),
      new VpStatement(0.915, 1.930, null, lineNumber: 29),
      new VpStatement(2.485, 0.470,  2.000, lineNumber: 30),
      new VpStatement(2.485, -1.030, null, lineNumber: 31),
      new VpStatement(1.605, -1.890, 10.700, lineNumber: 32),
      new VpStatement(-0.745, -0.654,  0.500, lineNumber: 33),
      new CstypeStatement(CSType.bezier, isRational: true, lineNumber: 34),
      new Curv2Statement([-6, -5, -4, -3, -2, -1, -6], lineNumber: 35),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0], lineNumber: 36),
      new SpStatement([2, 3], lineNumber: 37),
      new EndStatement(lineNumber: 38),
      new VStatement(-1.350, -1.030, 0.000, null, lineNumber: 41),
      new VStatement(0.130, -1.030, 0.432, 7.600, lineNumber: 42),
      new VStatement(1.480, -1.030, 0.000, 2.300, lineNumber: 43),
      new VStatement(-1.460, 0.060, 0.201, null, lineNumber: 44),
      new VStatement(0.120, 0.060, 0.915, 0.500, lineNumber: 45),
      new VStatement(1.380, 0.060, 0.454, 1.500, lineNumber: 46),
      new VStatement(-1.480, 1.030, 0.000, 2.300, lineNumber: 47),
      new VStatement(0.120, 1.030, 0.394, 6.100, lineNumber: 48),
      new VStatement(1.170, 1.030, 0.000, 3.300, lineNumber: 49),
      new CstypeStatement(CSType.bSpline, isRational: true, lineNumber: 50),
      new DegStatement(2, 2, lineNumber: 51),
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
      ], lineNumber: 52),
      new ParmStatement(ParameterDirection.u, [-1.00, -1.00, -1.00, 2.50, 2.50, 2.50], lineNumber: 53),
      new ParmStatement(ParameterDirection.v, [-2.00, -2.00, -2.00, 2.00, 2.00, 2.00], lineNumber: 54),
      new TrimStatement([new Curve2Instance(0.0, 2.0, 1)], lineNumber: 55),
      new SpStatement([4], lineNumber: 56),
      new EndStatement(lineNumber: 57)
    ]));

    expect(results.errors, isEmpty);
  });
}

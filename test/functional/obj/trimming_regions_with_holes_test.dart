import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/trimming_regions_with_holes.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/trimming_regions_with_holes.obj');
    final results = await statementizeObjResource(resource);

    expect(results.statements, equals([
      new DegStatement(1, null, lineNumber: 6),
      new CstypeStatement(CSType.bezier, lineNumber: 7),
      new VpStatement(0.1, 0.1, null, lineNumber: 8),
      new VpStatement(0.9, 0.1, null, lineNumber: 9),
      new VpStatement(0.9, 0.9, null, lineNumber: 10),
      new VpStatement(0.1, 0.9, null, lineNumber: 11),
      new Curv2Statement([1, 2, 3, 4, 1], lineNumber: 12),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0, 3.0, 4.0], lineNumber: 13),
      new EndStatement(lineNumber: 14),
      new VpStatement(0.3, 0.3, null, lineNumber: 17),
      new VpStatement(0.7, 0.3, null, lineNumber: 18),
      new VpStatement(0.7, 0.7, null, lineNumber: 19),
      new VpStatement(0.3, 0.7, null, lineNumber: 20),
      new Curv2Statement([5, 6, 7, 8, 5], lineNumber: 21),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0, 3.0, 4.0], lineNumber: 22),
      new EndStatement(lineNumber: 23),
      new VpStatement(1.1, 1.1, null, lineNumber: 26),
      new VpStatement(1.9, 1.1, null, lineNumber: 27),
      new VpStatement(1.9, 1.9, null, lineNumber: 28),
      new VpStatement(1.1, 1.9, null, lineNumber: 29),
      new Curv2Statement([9, 10, 11, 12, 9], lineNumber: 30),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0, 3.0, 4.0], lineNumber: 31),
      new EndStatement(lineNumber: 32),
      new VpStatement(1.3, 1.3, null, lineNumber: 35),
      new VpStatement(1.7, 1.3, null, lineNumber: 36),
      new VpStatement(1.7, 1.7, null, lineNumber: 37),
      new VpStatement(1.3, 1.7, null, lineNumber: 38),
      new Curv2Statement([13, 14, 15, 16, 13], lineNumber: 39),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0, 3.0, 4.0], lineNumber: 40),
      new EndStatement(lineNumber: 41),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 44),
      new VStatement(1.0, 0.0, 0.0, null, lineNumber: 45),
      new VStatement(0.0, 1.0, 0.0, null, lineNumber: 46),
      new VStatement(1.0, 1.0, 0.0, null, lineNumber: 47),
      new DegStatement(1, 1, lineNumber: 48),
      new CstypeStatement(CSType.bezier, lineNumber: 49),
      new SurfStatement(0.0, 2.0, 0.0, 2.0, [
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
        new VertexNumTriple(4)
      ], lineNumber: 50),
      new ParmStatement(ParameterDirection.u, [0.0, 2.0], lineNumber: 51),
      new ParmStatement(ParameterDirection.v, [0.0, 2.0], lineNumber: 52),
      new TrimStatement([new Curve2Instance(0.0, 4.0, 1)], lineNumber: 53),
      new HoleStatement([new Curve2Instance(0.0, 4.0, 2)], lineNumber: 54),
      new TrimStatement([new Curve2Instance(0.0, 4.0, 3)], lineNumber: 55),
      new HoleStatement([new Curve2Instance(0.0, 4.0, 4)], lineNumber: 56),
      new EndStatement(lineNumber: 57)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/surface_connectivity.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/surface_connectivity.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new CstypeStatement(CSType.bezier, lineNumber: 5),
      new DegStatement(1, 1, lineNumber: 6),
      new VpStatement(0.0, 0.0, null, lineNumber: 9),
      new VpStatement(1.0, 0.0, null, lineNumber: 10),
      new VpStatement(1.0, 1.0, null, lineNumber: 11),
      new VpStatement(0.0, 1.0, null, lineNumber: 12),
      new Curv2Statement([1, 2, 3, 4, 1], lineNumber: 13),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0, 3.0, 4.0], lineNumber: 14),
      new EndStatement(lineNumber: 15),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 18),
      new VStatement(1.0, 0.0, 0.0, null, lineNumber: 19),
      new VStatement(0.0, 1.0, 0.0, null, lineNumber: 20),
      new VStatement(1.0, 1.0, 0.0, null, lineNumber: 21),
      new SurfStatement(0.0, 1.0, 0.0, 1.0, [
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
        new VertexNumTriple(4),
      ], lineNumber: 22),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0], lineNumber: 23),
      new ParmStatement(ParameterDirection.v, [0.0, 1.0], lineNumber: 24),
      new TrimStatement([new Curve2Instance(0.0, 4.0, 1)], lineNumber: 25),
      new EndStatement(lineNumber: 26),
      new VStatement(1.0, 0.0, 0.0, null, lineNumber: 29),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 30),
      new VStatement(1.0, 1.0, 0.0, null, lineNumber: 31),
      new VStatement(2.0, 1.0, 0.0, null, lineNumber: 32),
      new SurfStatement(0.0, 1.0, 0.0, 1.0, [
        new VertexNumTriple(5),
        new VertexNumTriple(6),
        new VertexNumTriple(7),
        new VertexNumTriple(8),
      ], lineNumber: 33),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0], lineNumber: 34),
      new ParmStatement(ParameterDirection.v, [0.0, 1.0], lineNumber: 35),
      new TrimStatement([new Curve2Instance(0.0, 4.0, 1)], lineNumber: 36),
      new EndStatement(lineNumber: 37),
      new ConStatement(1, new Curve2Instance(2.0, 2.0, 1), 2, new Curve2Instance(4.0, 3.0, 1), lineNumber: 40)
    ]));

    expect(results.errors, isEmpty);
  });
}

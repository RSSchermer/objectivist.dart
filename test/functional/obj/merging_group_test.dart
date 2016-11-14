import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/merging_group.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/merging_group.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VStatement(-4.949854, -5.0, 0.0, null, lineNumber: 7),
      new VStatement(-4.949854, -1.666667, 0.0, null, lineNumber: 8),
      new VStatement(-4.949854, 1.666667, 0.0, null, lineNumber: 9),
      new VStatement(-4.949854, 5.0, 0.0, null, lineNumber: 10),
      new VStatement(-1.616521, -5.0, 0.0, null, lineNumber: 11),
      new VStatement(-1.616521, -1.666667, 0.0, null, lineNumber: 12),
      new VStatement(-1.616521, 1.666667, 0.0, null, lineNumber: 13),
      new VStatement(-1.616521, 5.0, 0.0, null, lineNumber: 14),
      new VStatement(1.716813, -5.0, 0.0, null, lineNumber: 15),
      new VStatement(1.716813, -1.666667, 0.0, null, lineNumber: 16),
      new VStatement(1.716813, 1.666667, 0.0, null, lineNumber: 17),
      new VStatement(1.716813, 5.0, 0.0, null, lineNumber: 18),
      new VStatement(5.050146, -5.0, 0.0, null, lineNumber: 19),
      new VStatement(5.050146, -1.666667, 0.0, null, lineNumber: 20),
      new VStatement(5.050146, 1.666667, 0.0, null, lineNumber: 21),
      new VStatement(5.050146, 5.0, 0.0, null, lineNumber: 22),
      new VStatement(-15.015566, -4.974991, 0.0, null, lineNumber: 23),
      new VStatement(-15.015566, -1.641658, 0.0, null, lineNumber: 24),
      new VStatement(-15.015566, 1.691675, 0.0, null, lineNumber: 25),
      new VStatement(-15.015566, 5.025009, 0.0, null, lineNumber: 26),
      new VStatement(-11.682233, -4.974991, 0.0, null, lineNumber: 27),
      new VStatement(-11.682233, -1.641658, 0.0, null, lineNumber: 28),
      new VStatement(-11.682233, 1.691675, 0.0, null, lineNumber: 29),
      new VStatement(-11.682233, 5.025009, 0.0, null, lineNumber: 30),
      new VStatement(-8.348900, -4.974991, 0.0, null, lineNumber: 31),
      new VStatement(-8.348900, -1.641658, 0.0, null, lineNumber: 32),
      new VStatement(-8.348900, 1.691675, 0.0, null, lineNumber: 33),
      new VStatement(-8.348900, 5.025009, 0.0, null, lineNumber: 34),
      new VStatement(-5.015566, -4.974991, 0.0, null, lineNumber: 35),
      new VStatement(-5.015566, -1.641658, 0.0, null, lineNumber: 36),
      new VStatement(-5.015566, 1.691675, 0.0, null, lineNumber: 37),
      new VStatement(-5.015566, 5.025009, 0.0, null, lineNumber: 38),
      new MgStatement(1, 0.5, lineNumber: 40),
      new CstypeStatement(CSType.bezier, lineNumber: 42),
      new DegStatement(3, 3, lineNumber: 43),
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
      ], lineNumber: 44),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0], lineNumber: 46),
      new ParmStatement(ParameterDirection.v, [0.0, 1.0], lineNumber: 47),
      new EndStatement(lineNumber: 48),
      new SurfStatement(0.0, 1.0, 0.0, 1.0, [
        new VertexNumTriple(29),
        new VertexNumTriple(30),
        new VertexNumTriple(31),
        new VertexNumTriple(32),
        new VertexNumTriple(25),
        new VertexNumTriple(26),
        new VertexNumTriple(27),
        new VertexNumTriple(28),
        new VertexNumTriple(21),
        new VertexNumTriple(22),
        new VertexNumTriple(23),
        new VertexNumTriple(24),
        new VertexNumTriple(17),
        new VertexNumTriple(18),
        new VertexNumTriple(19),
        new VertexNumTriple(20)
      ], lineNumber: 49),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0], lineNumber: 51),
      new ParmStatement(ParameterDirection.v, [0.0, 1.0], lineNumber: 52),
      new EndStatement(lineNumber: 53)
    ]));

    expect(results.errors, isEmpty);
  });
}

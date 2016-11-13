import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/bezier_curve.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/bezier_curve.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VStatement(-2.3, 1.95, 0.0, null, lineNumber: 5),
      new VStatement(-2.2, 0.79, 0.0, null, lineNumber: 6),
      new VStatement(-2.34, -1.51, 0.0, null, lineNumber: 7),
      new VStatement(-1.53, -1.49, 0.0, null, lineNumber: 8),
      new VStatement(-0.72, -1.47, 0.0, null, lineNumber: 9),
      new VStatement(-0.78, 0.23, 0.0, null, lineNumber: 10),
      new VStatement(0.07, 0.25, 0.0, null, lineNumber: 11),
      new VStatement(0.92, 0.27, 0.0, null, lineNumber: 12),
      new VStatement(0.8, -1.61, 0.0, null, lineNumber: 13),
      new VStatement(1.62, -1.59, 0.0, null, lineNumber: 14),
      new VStatement(2.44, -1.57, 0.0, null, lineNumber: 15),
      new VStatement(2.69, 0.67, 0.0, null, lineNumber: 16),
      new VStatement(2.9, 1.98, 0.0, null, lineNumber: 17),
      new CstypeStatement(CSType.bezier, lineNumber: 20),
      new CtechStatement(new CurveConstantParametricSubdivision(1.0), lineNumber: 21),
      new DegStatement(3, null, lineNumber: 22),
      new CurvStatement(0.0, 4.0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], lineNumber: 23),
      new ParmStatement(ParameterDirection.u, [0.0, 1.0, 2.0, 3.0, 4.0], lineNumber: 25),
      new EndStatement(lineNumber: 27)
    ]));

    expect(results.errors, isEmpty);
  });
}

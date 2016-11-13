import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/obj/taylor_curve.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/examples/obj/taylor_curve.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VStatement(3.000, 1.000, -2.500, null, lineNumber: 9),
      new VStatement(2.300, -10.100, 0.500, null, lineNumber: 10),
      new VStatement(7.980, 5.400, -7.000, null, lineNumber: 11),
      new VStatement(8.300, -4.700, 18.100, null, lineNumber: 12),
      new VStatement(6.340, 2.030, 0.080, null, lineNumber: 13),
      new CstypeStatement(CSType.taylor, lineNumber: 14),
      new DegStatement(4, null, lineNumber: 15),
      new CurvStatement(0.5, 1.6, [1, 2, 3, 4, 5], lineNumber: 16),
      new ParmStatement(ParameterDirection.u, [0.0, 2.0], lineNumber: 17),
      new EndStatement(lineNumber: 18)
    ]));

    expect(results.errors, isEmpty);
  });
}

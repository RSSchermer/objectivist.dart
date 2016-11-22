import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/dissolved_green.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/dissolved_green.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('diss_green', lineNumber: 5),
      new KaStatement(new RGB(0.0, 1.0, 0.0), lineNumber: 6),
      new KdStatement(new RGB(0.0, 1.0, 0.0), lineNumber: 7),
      new DStatement(0.8, lineNumber: 8),
      new IllumStatement(IlluminationModel.illum1, lineNumber: 9)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/neon_green.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/neon_green.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('neon_green', lineNumber: 6),
      new KdStatement(new RGB(0.0, 1.0, 0.0), lineNumber: 7),
      new IllumStatement(IlluminationModel.illum0, lineNumber: 8)
    ]));

    expect(results.errors, isEmpty);
  });
}

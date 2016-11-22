import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/fake_windshield.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/fake_windshield.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('fake_windsh', lineNumber: 7),
      new KaStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 8),
      new KdStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 9),
      new KsStatement(new RGB(0.9, 0.9, 0.9), lineNumber: 10),
      new DStatement(0.1, lineNumber: 11),
      new NsStatement(200, lineNumber: 12),
      new IllumStatement(IlluminationModel.illum4, lineNumber: 13)
    ]));

    expect(results.errors, isEmpty);
  });
}

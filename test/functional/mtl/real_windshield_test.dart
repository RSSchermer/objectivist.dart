import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/real_windshield.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/real_windshield.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('real_windsh', lineNumber: 10),
      new KaStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 11),
      new KdStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 12),
      new KsStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 13),
      new TfStatement(new RGB(1.0, 1.0, 1.0), lineNumber: 14),
      new NsStatement(200, lineNumber: 15),
      new NiStatement(1.2, lineNumber: 16),
      new IllumStatement(IlluminationModel.illum6, lineNumber: 17)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/tin.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/tin.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('tin', lineNumber: 8),
      new KaStatement(new SpectralCurve('tin.rfl'), lineNumber: 9),
      new KdStatement(new SpectralCurve('tin.rfl'), lineNumber: 10),
      new KsStatement(new SpectralCurve('tin.rfl'), lineNumber: 11),
      new NsStatement(200, lineNumber: 12),
      new IllumStatement(IlluminationModel.illum3, lineNumber: 13)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/pine_wood.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/pine_wood.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('pine_wood', lineNumber: 12),
      new KaStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 13),
      new KdStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 14),
      new IllumStatement(IlluminationModel.illum1, lineNumber: 15),
      new MapKaStatement('pine.mpc', lineNumber: 16),
      new MapKdStatement('pine.mpc', lineNumber: 17),
    ]));

    expect(results.errors, isEmpty);
  });
}

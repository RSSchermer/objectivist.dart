import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/bumpy_leather.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/bumpy_leather.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('bumpy_leath', lineNumber: 14),
      new KaStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 15),
      new KdStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 16),
      new KsStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 17),
      new IllumStatement(IlluminationModel.illum2, lineNumber: 18),
      new MapKaStatement('brown.mpc', lineNumber: 19),
      new MapKdStatement('brown.mpc', lineNumber: 20),
      new MapKsStatement('brown.mpc', lineNumber: 21),
      new BumpStatement('leath.mpb', multiplier: 2.0, lineNumber: 22)
    ]));

    expect(results.errors, isEmpty);
  });
}

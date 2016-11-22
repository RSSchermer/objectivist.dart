import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/scaled_logo.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/scaled_logo.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new KaStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 12),
      new KdStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 13),
      new KsStatement(new SpectralCurve('ident.rfl', 1.0), lineNumber: 14),
      new IllumStatement(IlluminationModel.illum2, lineNumber: 15),
      new MapKaStatement('logo.mpc', scale: new DoubleTriple(1.2, 1.2, 0.0), lineNumber: 16),
      new MapKdStatement('logo.mpc', scale: new DoubleTriple(1.2, 1.2, 0.0), lineNumber: 17),
      new MapKsStatement('logo.mpc', scale: new DoubleTriple(1.2, 1.2, 0.0), lineNumber: 18)
    ]));

    expect(results.errors, isEmpty);
  });
}

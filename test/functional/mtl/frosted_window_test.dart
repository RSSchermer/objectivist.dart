import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/frosted_window.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/frosted_window.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('frost_wind', lineNumber: 13),
      new KaStatement(new RGB(0.2, 0.2, 0.2), lineNumber: 14),
      new KdStatement(new RGB(0.6, 0.6, 0.6), lineNumber: 15),
      new KsStatement(new RGB(0.1, 0.1, 0.1), lineNumber: 16),
      new DStatement(1.0, lineNumber: 17),
      new NsStatement(200, lineNumber: 18),
      new IllumStatement(IlluminationModel.illum2, lineNumber: 19),
      new MapDStatement('window.mps', rangeBase: 0.2, rangeGain: 0.8, lineNumber: 20)
    ]));

    expect(results.errors, isEmpty);
  });
}

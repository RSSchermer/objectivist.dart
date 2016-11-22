import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/fresnel_blue.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/fresnel_blue.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('fresnel_blu', lineNumber: 7),
      new KaStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 8),
      new KdStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 9),
      new KsStatement(new RGB(0.618, 0.876, 0.143), lineNumber: 10),
      new NsStatement(200, lineNumber: 11),
      new IllumStatement(IlluminationModel.illum5, lineNumber: 12)
    ]));

    expect(results.errors, isEmpty);
  });
}

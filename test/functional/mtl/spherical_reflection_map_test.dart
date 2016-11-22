import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/spherical_reflection_map.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/spherical_reflection_map.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new KaStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 10),
      new KdStatement(new RGB(0.0, 0.0, 0.0), lineNumber: 11),
      new KsStatement(new RGB(0.7, 0.7, 0.7), lineNumber: 12),
      new IllumStatement(IlluminationModel.illum1, lineNumber: 13),
      new ReflStatement(ReflectionMapType.sphere, 'chrome.rla', lineNumber: 14)
    ]));

    expect(results.errors, isEmpty);
  });
}

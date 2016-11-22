import 'package:objectivist/mtl_reading.dart';
import 'package:objectivist/mtl_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/shiny_green.mtl results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/mtl/examples/shiny_green.mtl');
    final results = await statementizeMtlResource(resource);

    expect(results.statements, equals([
      new NewmtlStatement('shiny_green', lineNumber: 6),
      new KaStatement(new RGB(0.0, 1.0, 0.0), lineNumber: 7),
      new KdStatement(new RGB(0.0, 1.0, 0.0), lineNumber: 8),
      new KsStatement(new RGB(1.0, 1.0, 1.0), lineNumber: 9),
      new NsStatement(200, lineNumber: 10),
      new IllumStatement(IlluminationModel.illum1, lineNumber: 11)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/obj_reading.dart';
import 'package:objectivist/obj_statements.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  test('statementizing examples/smoothing_group.obj results in the correct statements without errors', () async {
    final resource = new Resource('test/functional/obj/examples/smoothing_group.obj');
    final results = await statementizeResource(resource);

    expect(results.statements, equals([
      new VStatement(0.0, 2.0, 0.0, null, lineNumber: 6),
      new VStatement(0.0, 0.0, 0.0, null, lineNumber: 7),
      new VStatement(2.0, 0.0, 0.0, null, lineNumber: 8),
      new VStatement(2.0, 2.0, 0.0, null, lineNumber: 9),
      new VStatement(4.0, 0.0, -1.255298, null, lineNumber: 10),
      new VStatement(4.0, 2.0, -1.255298, null, lineNumber: 11),
      new GStatement(['all'], lineNumber: 14),
      new SStatement(1, lineNumber: 15),
      new FStatement([
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
        new VertexNumTriple(4)
      ], lineNumber: 16),
      new FStatement([
        new VertexNumTriple(4),
        new VertexNumTriple(3),
        new VertexNumTriple(5),
        new VertexNumTriple(6)
      ], lineNumber: 17)
    ]));

    expect(results.errors, isEmpty);
  });
}

import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('MtllibStatement', () {
    test('toSource returns the correct value', () {
      final statement = new MtllibStatement(['materials1.mtl', 'materials2.mtl']);

      expect(statement.toSource(), equals('mtllib materials1.mtl materials2.mtl'));
    });
  });
}
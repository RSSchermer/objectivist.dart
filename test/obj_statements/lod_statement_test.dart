import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('LodStatement', () {
    test('toSource returns the correct value', () {
      final statement = new LodStatement(10);

      expect(statement.toSource(), equals('lod 10'));
    });
  });
}
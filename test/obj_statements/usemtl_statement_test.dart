import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('UsemtlStatement', () {
    test('toSource returns the correct value', () {
      final statement = new UsemtlStatement('material1');

      expect(statement.toSource(), equals('usemtl material1'));
    });
  });
}
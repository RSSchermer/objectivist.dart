import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('NewmtlStatement', () {
    test('toSource returns the correct value', () {
      final statement = new NewmtlStatement('my_material');

      expect(statement.toSource(), equals('newmtl my_material'));
    });
  });
}
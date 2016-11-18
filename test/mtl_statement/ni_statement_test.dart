import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('NiStatement', () {
    test('toSource returns the correct value', () {
      final statement = new NiStatement(5.0);

      expect(statement.toSource(), equals('Ni 5.0'));
    });
  });
}
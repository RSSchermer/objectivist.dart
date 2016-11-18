import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('DStatement', () {
    group('toSource', () {
      test('returns the correct value', () {
        final statement = new DStatement(0.8);

        expect(statement.toSource(), equals('d 0.8'));
      });

      test('returns the correct value when halo is true', () {
        final statement = new DStatement(0.8, halo: true);

        expect(statement.toSource(), equals('d -halo 0.8'));
      });
    });
  });
}
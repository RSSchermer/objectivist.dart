import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('BevelStatement', () {
    group('toSource', () {
      test('returns the correct value with bevel enabled', () {
        final statement = new BevelStatement(true);

        expect(statement.toSource(), equals('bevel on'));
      });

      test('returns the correct value with bevel disabled', () {
        final statement = new BevelStatement(false);

        expect(statement.toSource(), equals('bevel off'));
      });
    });
  });
}

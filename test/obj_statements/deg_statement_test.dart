import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('DegStatement', () {
    group('toSource', () {
      test('returns the correct value when the v degree is null', () {
        final statement = new DegStatement(3, null);

        expect(statement.toSource(), equals('deg 3'));
      });

      test('returns the correct value when the v degree is not null', () {
        final statement = new DegStatement(3, 2);

        expect(statement.toSource(), equals('deg 3 2'));
      });
    });
  });
}
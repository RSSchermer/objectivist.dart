import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('DInterpStatement', () {
    group('toSource', () {
      test('returns the correct value with dissolve interpolation enabled', () {
        final statement = new DInterpStatement(true);

        expect(statement.toSource(), equals('d_interp on'));
      });

      test('returns the correct value with dissolve interpolation  disabled', () {
        final statement = new DInterpStatement(false);

        expect(statement.toSource(), equals('d_interp off'));
      });
    });
  });
}
import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('CInterpStatement', () {
    group('toSource', () {
      test('returns the correct value with color interpolation enabled', () {
        final statement = new CInterpStatement(true);

        expect(statement.toSource(), equals('c_interp on'));
      });

      test('returns the correct value with color interpolation  disabled', () {
        final statement = new CInterpStatement(false);

        expect(statement.toSource(), equals('c_interp off'));
      });
    });
  });
}
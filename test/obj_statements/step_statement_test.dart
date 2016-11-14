import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('StepStatement', () {
    test('toSource', () {
      test('returns the correct value when the v step is null', () {
        final statement = new StepStatement(3, null);

        expect(statement.toSource(), equals('step 3'));
      });

      test('returns the correct value when the v step is not null', () {
        final statement = new StepStatement(3, 2);

        expect(statement.toSource(), equals('step 3 2'));
      });
    });
  });
}
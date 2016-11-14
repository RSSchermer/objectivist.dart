import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('VStatement', () {
    group('toSource', () {
      test('returns the correct value when w is null', () {
        final statement = new VStatement(1.0, 2.0, 3.0, null);

        expect(statement.toSource(), equals('v 1.0 2.0 3.0'));
      });

      test('returns the correct value when w is not null', () {
        final statement = new VStatement(1.0, 2.0, 3.0, 4.0);

        expect(statement.toSource(), equals('v 1.0 2.0 3.0 4.0'));
      });
    });
  });
}

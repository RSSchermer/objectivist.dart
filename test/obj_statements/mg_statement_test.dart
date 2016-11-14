import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('MgStatement', () {
    group('toSource', () {
      test('returns the correct value with smoothing group 0', () {
        final statement = new MgStatement(0, 0.5);

        expect(statement.toSource(), equals('mg off'));
      });

      test('returns the correct value with smoothing group 2', () {
        final statement = new MgStatement(2, 0.5);

        expect(statement.toSource(), equals('mg 2 0.5'));
      });
    });
  });
}
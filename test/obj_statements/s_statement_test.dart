import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('SStatement', () {
    group('toSource', () {
      test('returns the correct value with smoothing group 0', () {
        final statement = new SStatement(0);

        expect(statement.toSource(), equals('s off'));
      });

      test('returns the correct value with smoothing group 2', () {
        final statement = new SStatement(2);

        expect(statement.toSource(), equals('s 2'));
      });
    });
  });
}
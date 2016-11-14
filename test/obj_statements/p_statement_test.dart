import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('PStatement', () {
    test('toSource returns the correct value', () {
      final statement = new PStatement([1, 2, 3]);

      expect(statement.toSource(), equals('p 1 2 3'));
    });
  });
}
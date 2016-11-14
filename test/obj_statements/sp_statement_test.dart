import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('SpStatement', () {
    test('toSource returns the correct value', () {
      final statement = new SpStatement([1, 2, 3]);

      expect(statement.toSource(), equals('sp 1 2 3'));
    });
  });
}
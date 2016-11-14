import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('OStatement', () {
    test('toSource returns the correct value', () {
      final statement = new OStatement('object1');

      expect(statement.toSource(), equals('o object1'));
    });
  });
}
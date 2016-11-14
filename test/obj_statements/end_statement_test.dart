import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('EndStatement', () {
    test('toSource returns the correct value', () {
      final statement = new EndStatement();

      expect(statement.toSource(), equals('end'));
    });
  });
}
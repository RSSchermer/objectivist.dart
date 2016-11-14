import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('Curv2Statement', () {
    test('toSource returns the correct value', () {
      final statement = new Curv2Statement([10, 11, 12]);

      expect(statement.toSource(), equals('curv2 10 11 12'));
    });
  });
}
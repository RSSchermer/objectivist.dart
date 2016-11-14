import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('CurvStatement', () {
    test('toSource returns the correct value', () {
      final statement = new CurvStatement(1.0, 2.0, [10, 11, 12]);

      expect(statement.toSource(), equals('curv 1.0 2.0 10 11 12'));
    });
  });
}
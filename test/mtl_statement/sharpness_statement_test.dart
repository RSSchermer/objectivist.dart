import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('SharpnessStatement', () {
    test('toSource returns the correct value', () {
      final statement = new SharpnessStatement(100);

      expect(statement.toSource(), equals('sharpness 100'));
    });
  });
}
import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('GStatement', () {
    test('toSource returns the correct value', () {
      final statement = new GStatement(['group1', 'group2']);

      expect(statement.toSource(), equals('g group1 group2'));
    });
  });
}
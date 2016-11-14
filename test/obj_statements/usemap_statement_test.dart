import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('UsemapStatement', () {
    test('toSource returns the correct value', () {
      final statement = new UsemapStatement('map1');

      expect(statement.toSource(), equals('usemap map1'));
    });
  });
}
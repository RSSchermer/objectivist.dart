import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('MaplibStatement', () {
    test('toSource returns the correct value', () {
      final statement = new MaplibStatement(['maps1.map', 'maps2.map']);

      expect(statement.toSource(), equals('maplib maps1.map maps2.map'));
    });
  });
}
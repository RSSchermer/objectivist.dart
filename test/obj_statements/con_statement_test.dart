import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('ConStatement', () {
    test('toSource returns the correct value', () {
      final statement = new ConStatement(1, new Curve2Instance(1.0, 2.0, 1), 2,
          new Curve2Instance(3.0, 4.0, 2));

      expect(statement.toSource(), equals('con 1 1.0 2.0 1 2 3.0 4.0 2'));
    });
  });
}
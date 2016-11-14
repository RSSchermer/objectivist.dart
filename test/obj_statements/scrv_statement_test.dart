import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('ScrvStatement', () {
    test('toSource returns the correct value', () {
      final statement = new ScrvStatement([
        new Curve2Instance(1.0, 2.0, 1),
        new Curve2Instance(3.0, 4.0, 2)
      ]);

      expect(statement.toSource(), equals('scrv 1.0 2.0 1 3.0 4.0 2'));
    });
  });
}
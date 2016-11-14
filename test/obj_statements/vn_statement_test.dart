import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('VnStatement', () {
    test('toSource returns the correct value', () {
      final statement = new VnStatement(1.0, 2.0, 3.0);

      expect(statement.toSource(), equals('vn 1.0 2.0 3.0'));
    });
  });
}
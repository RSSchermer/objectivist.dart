import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('NsStatement', () {
    test('toSource returns the correct value', () {
      final statement = new NsStatement(100);

      expect(statement.toSource(), equals('Ns 100'));
    });
  });
}

import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('BmatStatement', () {
    group('toSource', () {
      test('returns the correct value for parameter direction u', () {
        final statement = new BmatStatement(ParameterDirection.u, [1.0, 2.0, 3.0, 4.0]);

        expect(statement.toSource(), equals('bmat u 1.0 2.0 3.0 4.0'));
      });

      test('returns the correct value for parameter direction v', () {
        final statement = new BmatStatement(ParameterDirection.v, [1.0, 2.0, 3.0, 4.0]);

        expect(statement.toSource(), equals('bmat v 1.0 2.0 3.0 4.0'));
      });
    });
  });
}
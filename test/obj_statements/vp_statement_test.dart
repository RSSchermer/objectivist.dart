import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('VpStatement', () {
    group('toSource', () {
      test('returns the correct value when v and w are null', () {
        final statement = new VpStatement(1.0, null, null);

        expect(statement.toSource(), equals('vp 1.0'));
      });

      test('returns the correct value when v is not null and w is null', () {
        final statement = new VpStatement(1.0, 2.0, null);

        expect(statement.toSource(), equals('vp 1.0 2.0'));
      });

      test('returns the correct value when v and w are not null', () {
        final statement = new VpStatement(1.0, 2.0, 3.0);

        expect(statement.toSource(), equals('vp 1.0 2.0 3.0'));
      });
    });
  });
}
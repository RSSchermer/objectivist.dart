import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('SharpnessStatement', () {
    group('toSource', () {
      test('returns the correct value when antialiasingEnabled is true', () {
        final statement = new MapAatStatement(true);

        expect(statement.toSource(), equals('map_aat on'));
      });

      test('returns the correct value when antialiasingEnabled is false', () {
        final statement = new MapAatStatement(false);

        expect(statement.toSource(), equals('map_aat off'));
      });
    });
  });
}
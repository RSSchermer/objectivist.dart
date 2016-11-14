import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('LStatement', () {
    group('toSource', () {
      test('returns the correct value without texture vertices', () {
        final statement = new LStatement([
          new VertexNumPair(1),
          new VertexNumPair(2),
          new VertexNumPair(3),
        ]);

        expect(statement.toSource(), equals('l 1 2 3'));
      });

      test('returns the correct value with texture vertices', () {
        final statement = new LStatement([
          new VertexNumPair(1, 11),
          new VertexNumPair(2, 12),
          new VertexNumPair(3, 13),
        ]);

        expect(statement.toSource(), equals('l 1/11 2/12 3/13'));
      });
    });
  });
}
import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('SurfStatement', () {
    test('returns the correct value without texture vertices and without vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1 2 3'));
    });

    test('returns the correct value with texture vertices and without vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1, 11),
        new VertexNumTriple(2, 12),
        new VertexNumTriple(3, 13),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1/11 2/12 3/13'));
    });

    test('returns the correct value without texture vertices and with vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1, null, 9),
        new VertexNumTriple(2, null, 8),
        new VertexNumTriple(3, null, 7),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1//9 2//8 3//7'));
    });

    test('returns the correct value with texture vertices and with vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1, 11, 9),
        new VertexNumTriple(2, 12, 8),
        new VertexNumTriple(3, 13, 7),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1/11/9 2/12/8 3/13/7'));
    });
  });
}
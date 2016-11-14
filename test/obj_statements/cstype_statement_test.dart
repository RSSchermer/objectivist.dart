import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('CstypeStatement', () {
    group('toSource', () {
      test('returns the correct value with type basisMatrix not ratial', () {
        final statement = new CstypeStatement(CSType.basisMatrix);

        expect(statement.toSource(), equals('cstype bmatrix'));
      });

      test('returns the correct value with type basisMatrix ratial', () {
        final statement = new CstypeStatement(CSType.basisMatrix, isRational: true);

        expect(statement.toSource(), equals('cstype rat bmatrix'));
      });

      test('returns the correct value with type bezier not ratial', () {
        final statement = new CstypeStatement(CSType.bezier);

        expect(statement.toSource(), equals('cstype bezier'));
      });

      test('returns the correct value with type bezier ratial', () {
        final statement = new CstypeStatement(CSType.bezier, isRational: true);

        expect(statement.toSource(), equals('cstype rat bezier'));
      });

      test('returns the correct value with type bSpline not ratial', () {
        final statement = new CstypeStatement(CSType.bSpline);

        expect(statement.toSource(), equals('cstype bspline'));
      });

      test('returns the correct value with type bSpline ratial', () {
        final statement = new CstypeStatement(CSType.bSpline, isRational: true);

        expect(statement.toSource(), equals('cstype rat bspline'));
      });

      test('returns the correct value with type cardinal not ratial', () {
        final statement = new CstypeStatement(CSType.cardinal);

        expect(statement.toSource(), equals('cstype cardinal'));
      });

      test('returns the correct value with type cardinal ratial', () {
        final statement = new CstypeStatement(CSType.cardinal, isRational: true);

        expect(statement.toSource(), equals('cstype rat cardinal'));
      });

      test('returns the correct value with type taylor not ratial', () {
        final statement = new CstypeStatement(CSType.taylor);

        expect(statement.toSource(), equals('cstype taylor'));
      });

      test('returns the correct value with type taylor ratial', () {
        final statement = new CstypeStatement(CSType.taylor, isRational: true);

        expect(statement.toSource(), equals('cstype rat taylor'));
      });
    });
  });
}
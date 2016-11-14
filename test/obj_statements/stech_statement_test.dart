import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('StechStatement', () {
    group('toSource', () {
      test('returns the correct value with a constantParametricSubdivisionA technique', () {
        final statement = new StechStatement(new SurfaceConstantParametricSubdivisionA(10.0, 15.0));

        expect(statement.toSource(), equals('stech cparma 10.0 15.0'));
      });

      test('returns the correct value with a constantParametricSubdivisionB technique', () {
        final statement = new StechStatement(new SurfaceConstantParametricSubdivisionB(10.0));

        expect(statement.toSource(), equals('stech cparmb 10.0'));
      });

      test('returns the correct value with a constantSpatialSubdivision technique', () {
        final statement = new StechStatement(new SurfaceConstantSpatialSubdivision(0.5));

        expect(statement.toSource(), equals('stech cspace 0.5'));
      });

      test('returns the correct value with a curvatureDependentSubdivision technique', () {
        final statement = new StechStatement(new SurfaceCurvatureDependentSubdivision(0.5, 5.0));

        expect(statement.toSource(), equals('stech curve 0.5 5.0'));
      });
    });
  });
}
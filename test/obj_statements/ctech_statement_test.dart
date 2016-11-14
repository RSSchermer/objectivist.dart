import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('CtechStatement', () {
    group('toSource', () {
      test('returns the correct value with a constantParametricSubdivision technique', () {
        final statement = new CtechStatement(new CurveConstantParametricSubdivision(10.0));

        expect(statement.toSource(), equals('ctech cparm 10.0'));
      });

      test('returns the correct value with a constantSpatialSubdivision technique', () {
        final statement = new CtechStatement(new CurveConstantSpatialSubdivision(0.5));

        expect(statement.toSource(), equals('ctech cspace 0.5'));
      });

      test('returns the correct value with a curvatureDependentSubdivision technique', () {
        final statement = new CtechStatement(new CurveCurvatureDependentSubdivision(0.5, 5.0));

        expect(statement.toSource(), equals('ctech curve 0.5 5.0'));
      });
    });
  });
}
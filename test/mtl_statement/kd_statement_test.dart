import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('KdStatement', () {
    group('toSource', () {
      test('returns the correct value with an RGB color source', () {
        final color = new RGB(0.1, 0.2, 0.3);
        final statement = new KdStatement(color);

        expect(statement.toSource(), equals('Kd 0.1 0.2 0.3'));
      });

      test('returns the correct value with an RGB color source with only the r channel specified', () {
        final color = new RGB(0.1);
        final statement = new KdStatement(color);

        expect(statement.toSource(), equals('Kd 0.1'));
      });

      test('returns the correct value with an CIEXYZ color source', () {
        final color = new CIEXYZ(0.1, 0.2, 0.3);
        final statement = new KdStatement(color);

        expect(statement.toSource(), equals('Kd xyz 0.1 0.2 0.3'));
      });

      test('returns the correct value with an CIEXYZ color source with only the x coordinate specified', () {
        final color = new CIEXYZ(0.1);
        final statement = new KdStatement(color);

        expect(statement.toSource(), equals('Kd xyz 0.1'));
      });

      test('returns the correct value with an spectral curve color source', () {
        final color = new SpectralCurve('spectral_curve.rfl');
        final statement = new KdStatement(color);

        expect(statement.toSource(), equals('Kd spectral spectral_curve.rfl'));
      });

      test('returns the correct value with an spectral curve color source with a factor', () {
        final color = new SpectralCurve('spectral_curve.rfl', 0.8);
        final statement = new KdStatement(color);

        expect(statement.toSource(), equals('Kd spectral spectral_curve.rfl 0.8'));
      });
    });
  });
}
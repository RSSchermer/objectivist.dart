import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('DispStatement', () {
    group('toSource', () {
      test('returns the correct value when all options use default values', () {
        final statement = new DispStatement('my_texture.png');

        expect(statement.toSource(), equals('disp my_texture.png'));
      });

      test('returns the correct value with blendU set to false', () {
        final statement = new DispStatement('my_texture.png', blendU: false);

        expect(statement.toSource(), equals('disp -blendu off my_texture.png'));
      });

      test('returns the correct value with blendV set to false', () {
        final statement = new DispStatement('my_texture.png', blendV: false);

        expect(statement.toSource(), equals('disp -blendv off my_texture.png'));
      });

      test('returns the correct value with the channel set to r', () {
        final statement = new DispStatement('my_texture.png', channel: Channel.r);

        expect(statement.toSource(), equals('disp -imfchan r my_texture.png'));
      });

      test('returns the correct value with clamp set to true', () {
        final statement = new DispStatement('my_texture.png', clamp: true);

        expect(statement.toSource(), equals('disp -clamp on my_texture.png'));
      });

      test('returns the correct value with a non-default value for rangeBase', () {
        final statement = new DispStatement('my_texture.png', rangeBase: 0.5);

        expect(statement.toSource(), equals('disp -mm 0.5 1.0 my_texture.png'));
      });

      test('returns the correct value with a non-default value for rangeGain', () {
        final statement = new DispStatement('my_texture.png', rangeGain: 2.0);

        expect(statement.toSource(), equals('disp -mm 0.0 2.0 my_texture.png'));
      });

      test('returns the correct value with a non-default value for originOffset', () {
        final statement = new DispStatement('my_texture.png', originOffset: new DoubleTriple(0.1, 0.2, 0.3));

        expect(statement.toSource(), equals('disp -o 0.1 0.2 0.3 my_texture.png'));
      });

      test('returns the correct value with a non-default value for scale', () {
        final statement = new DispStatement('my_texture.png', scale: new DoubleTriple(1.0, 2.0, 3.0));

        expect(statement.toSource(), equals('disp -s 1.0 2.0 3.0 my_texture.png'));
      });

      test('returns the correct value with a non-default value for turbulence', () {
        final statement = new DispStatement('my_texture.png', turbulence: new DoubleTriple(0.1, 0.2, 0.3));

        expect(statement.toSource(), equals('disp -t 0.1 0.2 0.3 my_texture.png'));
      });

      test('returns the correct value with the textureResolution specified', () {
        final statement = new DispStatement('my_texture.png', textureResolution: 256);

        expect(statement.toSource(), equals('disp -texres 256 my_texture.png'));
      });
    });
  });
}

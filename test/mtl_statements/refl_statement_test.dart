import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('ReflStatement', () {
    group('toSource', () {
      test('returns the correct value with type sphere and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type sphere my_texture.png'));
      });

      test('returns the correct value with type cubeTop and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.cubeTop, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type cube_top my_texture.png'));
      });

      test('returns the correct value with type cubeBottom and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.cubeBottom, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type cube_bottom my_texture.png'));
      });

      test('returns the correct value with type cubeFront and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.cubeFront, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type cube_front my_texture.png'));
      });

      test('returns the correct value with type cubeBack and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.cubeBack, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type cube_back my_texture.png'));
      });

      test('returns the correct value with type cubeRight and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.cubeRight, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type cube_right my_texture.png'));
      });

      test('returns the correct value with type cubeLeft and all options using default values', () {
        final statement = new ReflStatement(ReflectionMapType.cubeLeft, 'my_texture.png');

        expect(statement.toSource(), equals('refl -type cube_left my_texture.png'));
      });

      test('returns the correct value with blendU set to false', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', blendU: false);

        expect(statement.toSource(), equals('refl -type sphere -blendu off my_texture.png'));
      });

      test('returns the correct value with blendV set to false', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', blendV: false);

        expect(statement.toSource(), equals('refl -type sphere -blendv off my_texture.png'));
      });

      test('returns the correct value with colorCorrection set to true', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', colorCorrection: true);

        expect(statement.toSource(), equals('refl -type sphere -cc on my_texture.png'));
      });

      test('returns the correct value with clamp set to true', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', clamp: true);

        expect(statement.toSource(), equals('refl -type sphere -clamp on my_texture.png'));
      });

      test('returns the correct value with a non-default value for rangeBase', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', rangeBase: 0.5);

        expect(statement.toSource(), equals('refl -type sphere -mm 0.5 1.0 my_texture.png'));
      });

      test('returns the correct value with a non-default value for rangeGain', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', rangeGain: 2.0);

        expect(statement.toSource(), equals('refl -type sphere -mm 0.0 2.0 my_texture.png'));
      });

      test('returns the correct value with a non-default value for originOffset', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', originOffset: new DoubleTriple(0.1, 0.2, 0.3));

        expect(statement.toSource(), equals('refl -type sphere -o 0.1 0.2 0.3 my_texture.png'));
      });

      test('returns the correct value with a non-default value for scale', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', scale: new DoubleTriple(1.0, 2.0, 3.0));

        expect(statement.toSource(), equals('refl -type sphere -s 1.0 2.0 3.0 my_texture.png'));
      });

      test('returns the correct value with a non-default value for turbulence', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', turbulence: new DoubleTriple(0.1, 0.2, 0.3));

        expect(statement.toSource(), equals('refl -type sphere -t 0.1 0.2 0.3 my_texture.png'));
      });

      test('returns the correct value with the textureResolution specified', () {
        final statement = new ReflStatement(ReflectionMapType.sphere, 'my_texture.png', textureResolution: 256);

        expect(statement.toSource(), equals('refl -type sphere -texres 256 my_texture.png'));
      });
    });
  });
}

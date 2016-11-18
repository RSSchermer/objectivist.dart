part of mtl_statements;

/// Enumerates the available reflection map types.
enum ReflectionMapType {
  spherical,
  cubeTop,
  cubeBottom,
  cubeFront,
  cubeBack,
  cubeLeft,
  cubeRight
}

/// Specifies an infinitely large sphere or cube that casts reflections onto the
/// material.
///
/// When a [type] of [ReflectionMapType.spherical] is specified, one texture
/// file is used for a sphere. Otherwise separate texture files should be
/// specified for each side of a cube with multiple separate [ReflStatement]s.
class ReflStatement implements MtlStatement {
  /// The name of the color texture file, the procedural texture file or the
  /// image file.
  final String filename;

  /// The type of the reflection map.
  final ReflectionMapType type;

  /// Whether or not blending in the `u` direction is turned on.
  final bool blendU;

  /// Whether or not blending in the `v` direction is turned on.
  final bool blendV;

  /// Whether or not color correction is turned on.
  final bool colorCorrection;

  /// Whether or not clamping is turned on.
  ///
  /// When clamping is on, textures are restricted to `0.0...1.0` in the uvw
  /// range.
  final bool clamp;

  /// Specifies a base value that should be added to all texture values.
  ///
  /// A positive value makes everything brighter; a negative value makes
  /// everything dimmer.
  final double rangeBase;

  /// Specifies a gain multiplier with which all texture values should be
  /// multiplied.
  final double rangeGain;

  /// Specifies an offset for the texture map's origin.
  ///
  /// For a 2D texture the first value is used to offset the origin in the
  /// horizontal direction and the second value is used to offset the origin in
  /// the vertical direction.
  ///
  /// For a 3D texture the first value is used to offset the origin in the
  /// horizontal direction, the second value is used to offset the origin in the
  /// vertical direction and the third value is used to offset the origin in the
  /// depth direction.
  final DoubleTriple originOffset;

  /// Specifies scaling for the texture map.
  ///
  /// For a 2D texture the first value in should be used as a scaling factor in
  /// the horizontal direction and the second value should be a used as a
  /// scaling factor in the vertical direction.
  ///
  /// For a 3D texture the first value in should be used as a scaling factor in
  /// the horizontal direction, the second value should be a used as a scaling
  /// factor in the vertical direction and the third value should be used as a
  /// scaling factor in the depth direction.
  final DoubleTriple scale;

  /// Specifies turbulence for the texture map.
  ///
  /// Adding turbulence to a texture along a specified direction adds variance
  /// to the original image and allows a simple image to be repeated over a
  /// larger area without noticeable tiling effects. Turbulence also lets you
  /// use a 2D image as if it were a solid texture, similar to 3D procedural
  /// textures like marble and granite.
  ///
  /// For a 2D texture the first value is used for the turbulence in the
  /// horizontal direction and the second value is used for the turbulence in
  /// the vertical direction.
  ///
  /// For a 3D texture the first value is used for the turbulence in the
  /// horizontal direction, the second value is used for the turbulence in the
  /// vertical direction and the third value is used for the turbulence in the
  /// depth direction.
  final DoubleTriple turbulence;

  /// Specifies the resolution of the texture that is created when an image is
  /// used.
  ///
  /// If `null`, then the default texture size should be the largest power of
  /// two that does not exceed the original image size.
  final int textureResolution;

  final int lineNumber;

  /// Instantiates a new [ReflStatement].
  ReflStatement(this.type, this.filename,
      {this.blendU: true,
      this.blendV: true,
      this.colorCorrection: false,
      this.clamp: false,
      this.rangeBase: 0.0,
      this.rangeGain: 1.0,
      this.originOffset: const DoubleTriple(0.0, 0.0, 0.0),
      this.scale: const DoubleTriple(1.0, 1.0, 1.0),
      this.turbulence: const DoubleTriple(0.0, 0.0, 0.0),
      this.textureResolution,
      this.lineNumber});

  void acceptVisit(MtlStatementVisitor visitor) {
    visitor.visitReflStatement(this);
  }

  String toSource() {
    var res = 'map_Ka -type ${_reflectionMapTypeStringMap[type]}';

    if (blendU != true) {
      res += ' -blendu off';
    }

    if (blendV != true) {
      res += ' -blendv off';
    }

    if (colorCorrection != false) {
      res += ' -cc on';
    }

    if (clamp != false) {
      res += ' -clamp on';
    }

    if (rangeBase != 0.0 || rangeGain != 1.0) {
      res += ' -mm $rangeBase $rangeGain';
    }

    if (originOffset != const DoubleTriple(0.0, 0.0, 0.0)) {
      res += ' -o ${originOffset.toSource()}';
    }

    if (scale != const DoubleTriple(1.0, 1.0, 1.0)) {
      res += ' -s ${scale.toSource()}';
    }

    if (turbulence != const DoubleTriple(0.0, 0.0, 0.0)) {
      res += ' -t ${turbulence.toSource()}';
    }

    if (textureResolution != null) {
      res += ' -texres $textureResolution';
    }

    return '$res $filename';
  }

  String toString() => 'ReflStatement($type, $filename, blendU: $blendU, '
      'blendV: $blendV, colorCorrection: $colorCorrection, clamp: $clamp, '
      'rangeBase: $rangeBase, rangeGain: $rangeGain, originOffset: '
      '$originOffset, scale: $scale, turbulence: $turbulence, '
      'textureResolution: $textureResolution, lineNumber: $lineNumber)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is ReflStatement &&
          other.filename == filename &&
          other.type == type &&
          other.blendU == blendU &&
          other.blendV == blendV &&
          other.colorCorrection == colorCorrection &&
          other.clamp == clamp &&
          other.rangeBase == rangeBase &&
          other.rangeGain == rangeGain &&
          other.originOffset == originOffset &&
          other.scale == scale &&
          other.turbulence == turbulence &&
          other.textureResolution == textureResolution &&
          other.lineNumber == lineNumber;
}

const _reflectionMapTypeStringMap = const {
  ReflectionMapType.spherical: 'sphere',
  ReflectionMapType.cubeTop: 'cube_top',
  ReflectionMapType.cubeBottom: 'cube_bottom',
  ReflectionMapType.cubeFront: 'cube_front',
  ReflectionMapType.cubeBack: 'cube_back',
  ReflectionMapType.cubeLeft: 'cube_left',
  ReflectionMapType.cubeRight: 'cube_right'
};

library mtl_statements;

part 'src/mtl_statements/bump_statement.dart';
part 'src/mtl_statements/d_statement.dart';
part 'src/mtl_statements/decal_statement.dart';
part 'src/mtl_statements/disp_statement.dart';
part 'src/mtl_statements/illum_statement.dart';
part 'src/mtl_statements/ka_statement.dart';
part 'src/mtl_statements/kd_statement.dart';
part 'src/mtl_statements/ks_statement.dart';
part 'src/mtl_statements/map_aat_statement.dart';
part 'src/mtl_statements/map_d_statement.dart';
part 'src/mtl_statements/map_ka_statement.dart';
part 'src/mtl_statements/map_kd_statement.dart';
part 'src/mtl_statements/map_ks_statement.dart';
part 'src/mtl_statements/map_ns_statement.dart';
part 'src/mtl_statements/newmtl_statement.dart';
part 'src/mtl_statements/ni_statement.dart';
part 'src/mtl_statements/ns_statement.dart';
part 'src/mtl_statements/refl_statement.dart';
part 'src/mtl_statements/sharpness_statement.dart';
part 'src/mtl_statements/tf_statement.dart';

/// Defines the interface for `obj` statements.
abstract class MtlStatement {
  /// The line number at which this [MtlStatement] occurred in its source file.
  ///
  /// May be `null` for [MtlStatement]s that did not originate from a source
  /// file.
  int get lineNumber;

  /// Accepts a visit from the [visitor].
  void acceptVisit(MtlStatementVisitor visitor);

  /// A valid source code representation of this [MtlStatement].
  String toSource();
}

abstract class MtlStatementVisitor {
  void visitBumpStatement(BumpStatement statement);

  void visitDStatement(DStatement statement);

  void visitDecalStatement(DecalStatement statement);

  void visitDispStatement(DispStatement statement);

  void visitIllumStatement(IllumStatement statement);

  void visitKaStatement(KaStatement statement);

  void visitKdStatement(KdStatement statement);

  void visitKsStatement(KsStatement statement);

  void visitMapAatStatement(MapAatStatement statement);

  void visitMapDStatement(MapDStatement statement);

  void visitMapKaStatement(MapKaStatement statement);

  void visitMapKdStatement(MapKdStatement statement);

  void visitMapKsStatement(MapKsStatement statement);

  void visitMapNsStatement(MapNsStatement statement);

  void visitNewmtlStatement(NewmtlStatement statement);

  void visitNiStatement(NiStatement statement);

  void visitNsStatement(NsStatement statement);

  void visitReflStatement(ReflStatement statement);

  void visitSharpnessStatement(SharpnessStatement statement);

  void visitTfStatement(TfStatement statement);
}

/// Enumerates the types of color composition information sources supported by
/// the MTL spec.
enum ColorSourceType { RGB, spectralCurve, CIEXYZ }

/// Enumerates the available channels in a texture.
enum Channel { r, g, b, m, l, z }

/// A source of color composition information.
abstract class ColorSource {
  /// The [ColorSourceType] for this [ColorSource].
  ColorSourceType get type;

  /// A valid source code representation of this [ColorSource].
  String toSource();
}

/// Defines a color in terms of its red, green and blue components.
class RGB implements ColorSource {
  final ColorSourceType type = ColorSourceType.RGB;

  /// The value of the red color color component.
  final double r;

  /// The value for the green color component.
  ///
  /// If the value is `null` then the value of [r] should be used for the green
  /// color component.
  final double g;

  /// The value for the blue color component.
  ///
  /// If the value is `null` then the value of [r] should be used for the blue
  /// color component.
  final double b;

  /// Creates a new [RGB] instance.
  RGB(this.r, [this.g, this.b]);

  String toSource() {
    if (g == null) {
      return r.toString();
    } else if (b == null) {
      return '$r $g';
    } else {
      return '$r $g $b';
    }
  }

  String toString() => 'RGB($r, $g, $b)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is RGB && other.r == r && other.g == g && other.b == b;
}

/// Defines a color composition with a spectral curve defined in a separate
/// `.rfl` file.
class SpectralCurve implements ColorSource {
  final ColorSourceType type = ColorSourceType.spectralCurve;

  /// The filename of the `.rfl` file.
  final String filename;

  /// A multiplier for the values in the `.rfl` file.
  final double factor;

  /// Creates a new [SpectralCurve] instance.
  SpectralCurve(this.filename, [this.factor = 1.0]);

  String toSource() {
    if (factor == 1.0) {
      return 'spectral $filename';
    } else {
      return 'spectral $filename $factor';
    }
  }

  String toString() => 'SpectralCurve($filename, $factor)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is SpectralCurve &&
          other.filename == filename &&
          other.factor == factor;
}

/// Defines a color composition in CIE XYZ space.
class CIEXYZ implements ColorSource {
  final ColorSourceType type = ColorSourceType.CIEXYZ;

  /// The `x` coordinate in the CIE XYZ space.
  final double x;

  /// The `Y` coordinate in the CIE XYZ space.
  ///
  /// If the value is `null` then the value of [x] should be used.
  final double y;

  /// The `[` coordinate in the CIE XYZ space.
  ///
  /// If the value is `null` then the value of [x] should be used.
  final double z;

  /// Creates a new [CIEXYZ] instance.
  CIEXYZ(this.x, [this.y, this.z]);

  String toSource() {
    if (y == null) {
      return 'xyz $x';
    } else if (z == null) {
      return 'xyz $x $y';
    } else {
      return 'xyz $x $y $z';
    }
  }

  String toString() => 'CIEXYZ($x, $y, $z)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is CIEXYZ && other.x == x && other.y == y && other.z == z;
}

/// A triple of `double` values.
class DoubleTriple {
  /// The first value.
  final double u;

  /// The second value.
  final double v;

  /// The third value.
  final double w;

  /// Instantiates a new [Offset].
  const DoubleTriple(this.u, [this.v, this.w]);

  String toSource() {
    if (w != null) {
      return '$u ${ v ?? 0.0} $w';
    } else if (v != null) {
      return '$u $v';
    } else {
      return u.toString();
    }
  }

  String toString() => '($u, $v, $w)';

  bool operator ==(other) =>
      identical(other, this) ||
      other is DoubleTriple && other.u == u && other.v == v && other.w == w;
}

const _channelStringMap = const {
  Channel.r: 'r',
  Channel.g: 'g',
  Channel.b: 'b',
  Channel.m: 'm',
  Channel.l: 'l',
  Channel.z: 'z'
};

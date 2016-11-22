part of mtl_reading.statement_builders;

class MapKaStatementBuilder extends _ColorMapStatementBuilder {
  final String statementName = 'map_Ka';

  MapKaStatementBuilder(int lineNumber) : super(lineNumber);

  MapKaStatement makeStatement(
          String filename,
          bool blendU,
          bool blendV,
          bool colorCorrection,
          bool clamp,
          double rangeBase,
          double rangeGain,
          DoubleTriple originOffset,
          DoubleTriple scale,
          DoubleTriple turbulence,
          int textureResolution,
          int lineNumber) =>
      new MapKaStatement(filename,
          blendU: blendU,
          blendV: blendV,
          colorCorrection: colorCorrection,
          clamp: clamp,
          rangeBase: rangeBase,
          rangeGain: rangeGain,
          originOffset: originOffset,
          scale: scale,
          turbulence: turbulence,
          textureResolution: textureResolution,
          lineNumber: lineNumber);
}

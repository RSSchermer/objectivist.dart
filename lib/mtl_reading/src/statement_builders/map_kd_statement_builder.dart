part of mtl_reading.statement_builders;

class MapKdStatementBuilder extends _ColorMapStatementBuilder {
  final String statementName = 'map_Kd';

  MapKdStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  MapKdStatement makeStatement(
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
      new MapKdStatement(filename,
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

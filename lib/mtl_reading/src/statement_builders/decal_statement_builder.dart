part of mtl_reading.statement_builders;

class DecalStatementBuilder extends _ScalarMapStatementBuilder {
  final String statementName = 'map_d';

  final Channel defaultChannel = Channel.m;

  DecalStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  DecalStatement makeStatement(
          String filename,
          bool blendU,
          bool blendV,
          Channel channel,
          bool clamp,
          double rangeBase,
          double rangeGain,
          DoubleTriple originOffset,
          DoubleTriple scale,
          DoubleTriple turbulence,
          int textureResolution,
          int lineNumber) =>
      new DecalStatement(filename,
          blendU: blendU,
          blendV: blendV,
          channel: channel,
          clamp: clamp,
          rangeBase: rangeBase,
          rangeGain: rangeGain,
          originOffset: originOffset,
          scale: scale,
          turbulence: turbulence,
          textureResolution: textureResolution,
          lineNumber: lineNumber);
}

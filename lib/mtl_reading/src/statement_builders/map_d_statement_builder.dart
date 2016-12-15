part of mtl_reading.statement_builders;

class MapDStatementBuilder extends _ScalarMapStatementBuilder {
  final String statementName = 'map_d';

  final Channel defaultChannel = Channel.l;

  MapDStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  MapDStatement makeStatement(
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
      new MapDStatement(filename,
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

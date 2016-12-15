part of mtl_reading.statement_builders;

class MapNsStatementBuilder extends _ScalarMapStatementBuilder {
  final String statementName = 'map_Ns';

  final Channel defaultChannel = Channel.l;

  MapNsStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  MapNsStatement makeStatement(
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
      new MapNsStatement(filename,
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

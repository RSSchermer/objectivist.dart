part of mtl_reading.statement_builders;

class DispStatementBuilder extends _ScalarMapStatementBuilder {
  final String statementName = 'disp';

  final Channel defaultChannel = Channel.l;

  DispStatementBuilder(int lineNumber) : super(lineNumber);

  DispStatement makeStatement(
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
      new DispStatement(filename,
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

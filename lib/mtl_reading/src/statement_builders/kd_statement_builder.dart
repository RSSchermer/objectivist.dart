part of mtl_reading.statement_builders;

class KdStatementBuilder extends _ColorStatementBuilder {
  final statementName = 'Kd';

  KdStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  KdStatement makeStatement(ColorSource color, int lineNumber) =>
      new KdStatement(color, lineNumber: lineNumber);
}

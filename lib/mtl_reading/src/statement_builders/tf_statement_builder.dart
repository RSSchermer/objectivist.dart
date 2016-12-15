part of mtl_reading.statement_builders;

class TfStatementBuilder extends _ColorStatementBuilder {
  final statementName = 'Tf';

  TfStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  TfStatement makeStatement(ColorSource color, int lineNumber) =>
      new TfStatement(color, lineNumber: lineNumber);
}

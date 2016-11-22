part of mtl_reading.statement_builders;

class TfStatementBuilder extends _ColorStatementBuilder {
  final statementName = 'Tf';

  TfStatementBuilder(int lineNumber) : super(lineNumber);

  TfStatement makeStatement(ColorSource color, int lineNumber) =>
      new TfStatement(color, lineNumber: lineNumber);
}

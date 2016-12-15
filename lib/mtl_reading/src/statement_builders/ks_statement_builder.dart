part of mtl_reading.statement_builders;

class KsStatementBuilder extends _ColorStatementBuilder {
  final statementName = 'Ks';

  KsStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  KsStatement makeStatement(ColorSource color, int lineNumber) =>
      new KsStatement(color, lineNumber: lineNumber);
}

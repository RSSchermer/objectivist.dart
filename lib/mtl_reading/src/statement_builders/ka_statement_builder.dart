part of mtl_reading.statement_builders;

class KaStatementBuilder extends _ColorStatementBuilder {
  final statementName = 'Ka';

  KaStatementBuilder(Uri sourceUri, int lineNumber)
      : super(sourceUri, lineNumber);

  KaStatement makeStatement(ColorSource color, int lineNumber) =>
      new KaStatement(color, lineNumber: lineNumber);
}

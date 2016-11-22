import 'package:objectivist/mtl_statements.dart';
import 'package:test/test.dart';

void main() {
  group('IllumStatement', () {
    group('toSource', () {
      test('returns the correct value for model 0', () {
        final statement = new IllumStatement(IlluminationModel.illum0);

        expect(statement.toSource(), equals('illum 0'));
      });

      test('returns the correct value for model 1', () {
        final statement = new IllumStatement(IlluminationModel.illum1);

        expect(statement.toSource(), equals('illum 1'));
      });

      test('returns the correct value for model 2', () {
        final statement = new IllumStatement(IlluminationModel.illum2);

        expect(statement.toSource(), equals('illum 2'));
      });

      test('returns the correct value for model 3', () {
        final statement = new IllumStatement(IlluminationModel.illum3);

        expect(statement.toSource(), equals('illum 3'));
      });

      test('returns the correct value for model 4', () {
        final statement = new IllumStatement(IlluminationModel.illum4);

        expect(statement.toSource(), equals('illum 4'));
      });

      test('returns the correct value for model 5', () {
        final statement = new IllumStatement(IlluminationModel.illum5);

        expect(statement.toSource(), equals('illum 5'));
      });

      test('returns the correct value for model 6', () {
        final statement = new IllumStatement(IlluminationModel.illum6);

        expect(statement.toSource(), equals('illum 6'));
      });

      test('returns the correct value for model 7', () {
        final statement = new IllumStatement(IlluminationModel.illum7);

        expect(statement.toSource(), equals('illum 7'));
      });

      test('returns the correct value for model 8', () {
        final statement = new IllumStatement(IlluminationModel.illum8);

        expect(statement.toSource(), equals('illum 8'));
      });

      test('returns the correct value for model 9', () {
        final statement = new IllumStatement(IlluminationModel.illum9);

        expect(statement.toSource(), equals('illum 9'));
      });

      test('returns the correct value for model 10', () {
        final statement = new IllumStatement(IlluminationModel.illum10);

        expect(statement.toSource(), equals('illum 10'));
      });
    });
  });
}
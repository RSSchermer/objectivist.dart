import 'package:objectivist/obj_reading/lexing.dart';
import 'package:test/test.dart';

void main() {
  group('ObjLexer', () {
    group('flush', () {
      test('all token types', () {
        final sourceString =
            'a_0-.b 1 1.0 1.1e12 1.1E12 \\ -1 -1.0 1.1e-12 1.1E-12\n# abc\n %fg';
        final lexer = new ObjLexer();

        for (var i = 0; i < sourceString.length; i++) {
          lexer.process(sourceString.codeUnitAt(i));
        }

        lexer.process(3); // Signal "end of text"

        expect(lexer.flush(), equals([
          new ObjToken(ObjTokenType.string, 'a_0-.b'),
          new ObjToken(ObjTokenType.int, '1'),
          new ObjToken(ObjTokenType.double, '1.0'),
          new ObjToken(ObjTokenType.double, '1.1e12'),
          new ObjToken(ObjTokenType.double, '1.1E12'),
          new ObjToken(ObjTokenType.backslash),
          new ObjToken(ObjTokenType.int, '-1'),
          new ObjToken(ObjTokenType.double, '-1.0'),
          new ObjToken(ObjTokenType.double, '1.1e-12'),
          new ObjToken(ObjTokenType.double, '1.1E-12'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.comment, '# abc'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.invalid, '%fg'),
          new ObjToken(ObjTokenType.endOfText)
        ]));
      });

      test('in between two strings that split a token includes the whole token as one in the second flush call', () {
        final sourceString1 = 'a ab';
        final lexer = new ObjLexer();
        final tokens = [];

        for (var i = 0; i < sourceString1.length; i++) {
          lexer.process(sourceString1.codeUnitAt(i));
        }

        tokens.addAll(lexer.flush());

        final sourceString2 = 'cd';

        for (var i = 0; i < sourceString2.length; i++) {
          lexer.process(sourceString2.codeUnitAt(i));
        }

        lexer.process(3); // Signal "end of text"
        tokens.addAll(lexer.flush());

        expect(tokens, equals([
          new ObjToken(ObjTokenType.string, 'a'),
          new ObjToken(ObjTokenType.string, 'abcd'),
          new ObjToken(ObjTokenType.endOfText)
        ]));
      });
    });

    group('clean', () {
      test('in between two strings that split a token discards the first half', () {
        final sourceString1 = 'a ab';
        final lexer = new ObjLexer();
        final tokens = [];

        for (var i = 0; i < sourceString1.length; i++) {
          lexer.process(sourceString1.codeUnitAt(i));
        }

        tokens.addAll(lexer.clean());

        final sourceString2 = 'cd';

        for (var i = 0; i < sourceString2.length; i++) {
          lexer.process(sourceString2.codeUnitAt(i));
        }

        lexer.process(3); // Signal "end of text"
        tokens.addAll(lexer.clean());

        expect(tokens, equals([
          new ObjToken(ObjTokenType.string, 'a'),
          new ObjToken(ObjTokenType.string, 'cd'),
          new ObjToken(ObjTokenType.endOfText)
        ]));
      });
    });
  });
}

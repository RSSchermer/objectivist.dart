import 'package:objectivist/obj_reading/lexing.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  group('ObjLexer', () {
    group('flush', () {
      test('all token types', () {
        final sourceString =
            'a_0-.b 1 1/2 1/2/3 1//3 1.0 1.1e12 1.1E12 \\ -1 -1/-2 -1/-2/-3 '
            '-1//-3 -1.0 1.1e-12 1.1E-12\n# abc\n %fg';
        final lexer = new ObjLexer();

        for (var i = 0; i < sourceString.length; i++) {
          lexer.process(sourceString.codeUnitAt(i));
        }

        lexer.process(3); // Signal "end of text"

        expect(lexer.flush(), equals([
          new ObjToken(ObjTokenType.string, 'a_0-.b'),
          new ObjToken(ObjTokenType.int, '1'),
          new ObjToken(ObjTokenType.intPair, '1/2'),
          new ObjToken(ObjTokenType.intTriple, '1/2/3'),
          new ObjToken(ObjTokenType.intTriple, '1//3'),
          new ObjToken(ObjTokenType.double, '1.0'),
          new ObjToken(ObjTokenType.double, '1.1e12'),
          new ObjToken(ObjTokenType.double, '1.1E12'),
          new ObjToken(ObjTokenType.backslash),
          new ObjToken(ObjTokenType.int, '-1'),
          new ObjToken(ObjTokenType.intPair, '-1/-2'),
          new ObjToken(ObjTokenType.intTriple, '-1/-2/-3'),
          new ObjToken(ObjTokenType.intTriple, '-1//-3'),
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

      test('with .obj file results in the correct tokens', () async {
        final source = new Resource('test/obj_examples/cube_polygon.obj');
        final sourceString = await source.readAsString();
        final lexer = new ObjLexer();

        for (var i = 0; i < sourceString.length; i++) {
          lexer.process(sourceString.codeUnitAt(i));
        }

        lexer.process(3); // Signal "end of text"

        expect(lexer.flush(), equals([
          new ObjToken(ObjTokenType.comment, '# Polygonal cube'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.comment, '#'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.comment, '# Example taken from OBJ 3.0 specification.'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'v'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '2.000000'),
          new ObjToken(ObjTokenType.double, '0.000000'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'f'),
          new ObjToken(ObjTokenType.int, '1'),
          new ObjToken(ObjTokenType.int, '2'),
          new ObjToken(ObjTokenType.int, '3'),
          new ObjToken(ObjTokenType.int, '4'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'f'),
          new ObjToken(ObjTokenType.int, '8'),
          new ObjToken(ObjTokenType.int, '7'),
          new ObjToken(ObjTokenType.int, '6'),
          new ObjToken(ObjTokenType.int, '5'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'f'),
          new ObjToken(ObjTokenType.int, '4'),
          new ObjToken(ObjTokenType.int, '3'),
          new ObjToken(ObjTokenType.int, '7'),
          new ObjToken(ObjTokenType.int, '8'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'f'),
          new ObjToken(ObjTokenType.int, '5'),
          new ObjToken(ObjTokenType.int, '1'),
          new ObjToken(ObjTokenType.int, '4'),
          new ObjToken(ObjTokenType.int, '8'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'f'),
          new ObjToken(ObjTokenType.int, '5'),
          new ObjToken(ObjTokenType.int, '6'),
          new ObjToken(ObjTokenType.int, '2'),
          new ObjToken(ObjTokenType.int, '1'),
          new ObjToken(ObjTokenType.newline),
          new ObjToken(ObjTokenType.string, 'f'),
          new ObjToken(ObjTokenType.int, '2'),
          new ObjToken(ObjTokenType.int, '6'),
          new ObjToken(ObjTokenType.int, '7'),
          new ObjToken(ObjTokenType.int, '3'),
          new ObjToken(ObjTokenType.newline),
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

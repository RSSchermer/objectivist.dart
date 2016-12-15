library mtl_reading.statementizing;

import 'dart:async';

import 'package:quiver/collection.dart';
import 'package:objectivist/mtl_statements.dart';

import 'errors.dart';
import 'lexing.dart';
import 'statement_builders.dart';

/// Buffering MTL token sequence statementizer.
///
/// Turns a sequence of [MtlToken]s into a sequence of [MtlStatement]s.
/// Statements will be buffered. See [flush] or [clean] for retrieving the
/// contents of the statement buffer.
class MtlStatementizer {
  final Uri sourceUri;

  int _lineNumber = 1;

  MtlStatementBuilder _statementBuilder;

  MtlToken _lastToken;

  List<MtlStatement> _statements = [];

  List<MtlReadingError> _errors = [];

  /// Instantiates a new [MtlStatementizer] for the given [sourceUri].
  MtlStatementizer(this.sourceUri);

  /// Processes the next token.
  ///
  /// Turns a sequence of [MtlToken]s into a sequence of [MtlStatement]s.
  /// Statements will be buffered. See [flush] or [clean] for retrieving the
  /// contents of the statement buffer.
  void process(MtlToken token) {
    if (token.type == MtlTokenType.newline) {
      _lineNumber++;
    }

    if (_statementBuilder == null) {
      switch (token.type) {
        case MtlTokenType.comment:
        case MtlTokenType.newline:
        case MtlTokenType.endOfText:
          break;
        case MtlTokenType.string:
          switch (token.value) {
            case 'bump':
              _statementBuilder =
                  new BumpStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'd':
              _statementBuilder = new DStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'decal':
              _statementBuilder =
                  new DecalStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'disp':
              _statementBuilder =
                  new DispStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'illum':
              _statementBuilder =
                  new IllumStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'Ka':
              _statementBuilder =
                  new KaStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'Kd':
              _statementBuilder =
                  new KdStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'Ks':
              _statementBuilder =
                  new KsStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'map_aat':
              _statementBuilder =
                  new MapAatStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'map_d':
              _statementBuilder =
                  new MapDStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'map_Ka':
              _statementBuilder =
                  new MapKaStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'map_Kd':
              _statementBuilder =
                  new MapKdStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'map_Ks':
              _statementBuilder =
                  new MapKsStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'map_Ns':
              _statementBuilder =
                  new MapNsStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'newmtl':
              _statementBuilder =
                  new NewmtlStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'Ni':
              _statementBuilder =
                  new NiStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'Ns':
              _statementBuilder =
                  new NsStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'refl':
              _statementBuilder =
                  new ReflStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'sharpness':
              _statementBuilder =
                  new SharpnessStatementBuilder(sourceUri, _lineNumber);
              break;
            case 'Tf':
              _statementBuilder =
                  new TfStatementBuilder(sourceUri, _lineNumber);
              break;
          }

          break;
        default:
          _errors.add(new MtlReadingError(sourceUri, _lineNumber,
              '${token.value} is not a valid way to start a new statement.'));
      }
    } else {
      if ((token.type == MtlTokenType.newline ||
                  token.type == MtlTokenType.comment) &&
              _lastToken.type != MtlTokenType.backslash ||
          token.type == MtlTokenType.endOfText) {
        final result = _statementBuilder.build();

        if (result.statement != null) {
          _statements.add(result.statement);
        } else {
          _errors.addAll(result.errors);
        }

        _statementBuilder = null;
      } else {
        switch (token.type) {
          case MtlTokenType.string:
            _statementBuilder.addStringArgument(token.value);
            break;
          case MtlTokenType.int:
            _statementBuilder.addIntArgument(int.parse(token.value));
            break;
          case MtlTokenType.double:
            _statementBuilder.addDoubleArgument(double.parse(token.value));
            break;
          default:
        }
      }
    }

    _lastToken = token;
  }

  /// Returns all buffered statements and empties the statement buffer, but
  /// leaves any currently unfinished token intact.
  ///
  /// If this [MtlStatementizer] currently has a partial unfinished statement,
  /// then that statement will be preserved. If any other tokens get processed
  /// subsequently, then these will be used to complete this statement and it
  /// will be the first statement when the statement buffer is flushed again at
  /// a later time.
  ///
  /// Returns a [MtlStatementizerResults] instance which acts as a collection of
  /// statements. Note that statements that contained errors may have been
  /// omitted from the [MtlStatementizerResults]. Call `errors` on the
  /// [MtlStatementizerResults] instance to retrieve the errors encountered
  /// while statementizing.
  ///
  /// See also [clean].
  MtlStatementizerResults flush() {
    final results = new MtlStatementizerResults._internal(_statements, _errors);

    _statements = [];
    _errors = [];

    return results;
  }

  /// Returns all buffered statements, empties the statement buffer and discards
  /// any currently unfinished statement.
  ///
  /// If this [MtlStatementizer] currently has a partial unfinished statement,
  /// then that statement will be discarded. Essentially resets this
  /// [MtlStatementizer] to its empty state.
  ///
  /// Returns a [MtlStatementizerResults] instance which acts as a collection of
  /// statements. Note that statements that contained errors may have been
  /// omitted from the [MtlStatementizerResults]. Call `errors` on the
  /// [MtlStatementizerResults] instance to retrieve the errors encountered
  /// while statementizing.
  ///
  /// See also [flush].
  MtlStatementizerResults clean() {
    _statementBuilder = null;
    _lastToken = null;
    _lineNumber = 0;

    final results = new MtlStatementizerResults._internal(_statements, _errors);

    _statements = [];
    _errors = [];

    return results;
  }
}

/// Encapsulates results produced by an [MtlStatementizer].
///
/// Acts as a collection of statements. Note that an [MtlStatementizer] may have
/// omitted statements that contained errors. Call [errors] to retrieve the
/// errors encountered by the [MtlStatementizer] while statementizing.
class MtlStatementizerResults extends DelegatingIterable<MtlStatement> {
  final Iterable<MtlStatement> delegate;

  /// The errors encountered while statementizing.
  final Iterable<MtlReadingError> errors;

  /// The collection of statements that resulted from statementizing.
  Iterable<MtlStatement> get statements => delegate;

  /// Creates a new [MtlStatementizerResults] instance.
  MtlStatementizerResults._internal(this.delegate, this.errors);
}

/// Transforms an [MtlToken] stream into an [MtlStatement] stream.
class ObjStatementizerTransformer
    implements StreamTransformer<Iterable<MtlToken>, MtlStatementizerResults> {
  /// The [MtlStatementizer] used to statementize an [MtlToken] stream.
  final MtlStatementizer statementizer;

  /// Instantiates a new [ObjStatementizerTransformer].
  ObjStatementizerTransformer(this.statementizer);

  Stream<MtlStatementizerResults> bind(Stream<Iterable<MtlToken>> stream) {
    final outStreamController = new StreamController<MtlStatementizerResults>();

    stream.listen((tokens) {
      for (var token in tokens) {
        statementizer.process(token);
      }

      outStreamController.add(statementizer.flush());
    });

    return outStreamController.stream;
  }
}

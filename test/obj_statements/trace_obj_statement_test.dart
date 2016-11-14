import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('TraceObjStatement', () {
    test('toSource returns the correct value', () {
      final statement = new TraceObjStatement('object1.obj');

      expect(statement.toSource(), equals('trace_obj object1.obj'));
    });
  });
}
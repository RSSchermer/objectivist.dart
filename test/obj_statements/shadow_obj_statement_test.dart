import 'package:objectivist/obj_statements.dart';
import 'package:test/test.dart';

void main() {
  group('ShadowObjStatement', () {
    test('toSource returns the correct value', () {
      final statement = new ShadowObjStatement('object1.obj');

      expect(statement.toSource(), equals('shadow_obj object1.obj'));
    });
  });
}
// Copyright (c) 2016, R.S. Schermer. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:objectivist/objectivist.dart';
import 'package:objectivist/obj_parser.dart';
import 'package:resource/resource.dart';
import 'package:test/test.dart';

void main() {
  final source = new Resource('test/obj_examples/test.obj');

  source.openRead().forEach((charCodes) {
    print(charCodes.length);
  });
}

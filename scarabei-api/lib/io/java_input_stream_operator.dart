import 'dart:async';

import 'package:scarabei_api/utils/byte_array.dart';

abstract class JavaInputStreamOperator {

  void closeStream();

  Stream<int> getJavaStream();

  bool isReadAllSupported();

  ByteArray readAll();
}

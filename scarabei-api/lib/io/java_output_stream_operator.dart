import 'dart:async';

import 'package:scarabei_api/utils/byte_array.dart';


abstract class JavaOutputStreamOperator {

  void closeStream();

  Stream getJavaStream();

  bool isBulkWriteSupported();

  void writeAll(ByteArray bytes);
}

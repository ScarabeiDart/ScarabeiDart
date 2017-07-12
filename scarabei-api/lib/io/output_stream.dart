library com.jfixby.scarabei.api.io;

import 'dart:async';

import 'package:scarabei_api/utils/byte_array.dart';


abstract class OutputStream {

  void flush();

  void write({ByteArray array, List<int> bytes});

  Stream toDartOutputStream();

  void open();

  void close();
}

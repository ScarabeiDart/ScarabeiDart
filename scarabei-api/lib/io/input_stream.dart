library com.jfixby.scarabei.api.io;


import 'dart:async';

import 'package:scarabei_api/utils/byte_array.dart';

abstract class InputStream {

  bool hasData();

  int read();

  int available();

  ByteArray readAll();

  String readAllToString({String encoding});

  Stream toDartInputStream();

  void open();

  void close();
}

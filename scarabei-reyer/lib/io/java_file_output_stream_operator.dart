import 'dart:async';
import "dart:io" as dart;

import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/io/java_output_stream_operator.dart';
import 'package:scarabei_api/utils/byte_array.dart';

class JavaFileOutputStreamOperator extends JavaOutputStreamOperator {
  dart.File file;
  Stream os;
  bool append;

  JavaFileOutputStreamOperator(dart.File file, bool append) {
    this.file = file;
    this.append = append;
  }

  void closeStream() {
    IO.forceClose(this.os);
    this.os = null;
  }

  OutputStream getJavaStream() {
    this.file.getParentFile().mkdirs();
    if (this.os == null) {
      this.os = new FileOutputStream(this.file, this.append);
      this.os = new java_io_BufferedOutputStream(this.os);
    }
    return this.os;
  }

  bool isBulkWriteSupported() {
    return false;
  }

  void writeAll(ByteArray bytes) {
    Err.throwNotImplementedYet();
  }
}

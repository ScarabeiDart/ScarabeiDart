import 'dart:async';
import "dart:io" as dart;

import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/utils/byte_array.dart';


class JavaFileInputStreamOperator
    implements JavaInputStreamOperator {
//  static int SIZE_LIMIT = Integer.MAX_VALUE;
  dart.File file;
  Stream is_;

  JavaFileInputStreamOperator(dart.File file) {
    this.file = file;
  }

  void closeStream() {
    IO.forceClose(this.is_);
    this.is_ = null;
  }

  Stream getJavaStream() {
    if (this.is_ == null) {
      this.is_ = new FileInputStream(this.file);
      this.is_ = new java_io_BufferedInputStream(this.is_);
    }
    return this.is_;
  }

  bool isReadAllSupported() {
    return false;
  }

  ByteArray readAll() {
    Err.throwNotImplementedYet();
    return null;
  }
}

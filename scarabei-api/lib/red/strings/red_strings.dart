import 'dart:convert';

import 'package:scarabei_api/api/error/err.dart';
import 'package:scarabei_api/api/log/logger.dart';
import 'package:scarabei_api/api/strings/strings.dart';

class RedStrings implements StringsComponent {

  @override
  String newString({List<int> bytes, String encoding}) {
    if (encoding != "utf8") {
      L.e("unknown encoding", encoding);
      Err.throwNotImplementedYet();
    }
    return UTF8.decode(bytes);
  }

  @override
  String replaceAll(String input, Map<String, String> termsMapping) {
    Err.throwNotImplementedYet();
    return null;
  }

  @override
  List<int> toBytes(String string_data) {
    return UTF8.encode(string_data);
  }

  @override
  String wrapSequence(Iterable<String> seq, String bracketLeft, String bracketRight, String separator) {
    final int iMax = seq.length - 1;
    if (iMax == -1) {
      return bracketLeft + bracketRight;
    }
    String result = "";
    result = result + (bracketLeft);
    for (int i = 0;; i++) {
//      b.append(seq.getElementAt(i));
      result = result + seq.elementAt(i);
      if (i == iMax) {
        return result = result + bracketRight;
      }
      result = result + (separator);
    }
  }
}
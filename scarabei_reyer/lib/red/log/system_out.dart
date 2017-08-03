import 'package:scarabei/api/log/logger.dart';

class SystemOut implements ConsoleOut {
  int pad = 90 + 23;
  String split = "|";

  @override
  void out(OUT_MODE mode, String frame, String msg) {
//    frame = "";
//    pad = 0;
//    split = "";
    String marker = "";
    if (mode == OUT_MODE.DEBUG) {
      marker = "";
    } else {
      marker = "WARNING: ";
    }
    List<String> list = msg.split("\n");
    for (int i = 0; i < list.length; i++) {
      print((marker + frame + split).padLeft(pad, ' ') + " " + list[i]);
    }
  }
}

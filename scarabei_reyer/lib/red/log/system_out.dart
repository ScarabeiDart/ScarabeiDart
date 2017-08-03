import 'package:scarabei/api/log/logger.dart';

class SystemOut implements ConsoleOut {
  int pad = 90;
  String split = "|";

  @override
  void out(OUT_MODE mode, String frame, String msg) {
//    frame = "";
//    pad = 0;
//    split = "";
    if (mode == OUT_MODE.DEBUG) {
      print((frame + split).padLeft(pad, ' ') + " " + msg);
    } else {
      print(("WARNING: " + frame + split).padLeft(pad, ' ') + " " + msg);
    }
  }
}

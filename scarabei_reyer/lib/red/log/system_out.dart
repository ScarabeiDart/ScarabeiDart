import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings.dart';

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
      if (SystemSettings.component() == null || SystemSettings.getExecutionMode().isBelow(ExecutionMode.TESTING)) {
        print(list[i]);
      } else {
        print((marker + frame + split).padLeft(pad, ' ') + " " + list[i]);
      }
    }
  }
}

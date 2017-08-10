import 'package:scarabei/api/lang/lang.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings.dart';
import 'package:scarabei_reyer/red/log/system_out.dart';

class SimpleLogger extends LoggerComponent {
  SimpleLogger([ConsoleOut out]) {
    _console_out = out;
    if (_console_out == null) {
      _console_out = new SystemOut();
    }
  }

  static String getFrame() {
    if (SystemSettings.getExecutionMode().isBelow(ExecutionMode.TESTING)) {
      return "scarabei";
    }
    StackTrace stack = StackTrace.current;
    String str = stack.toString();
//    print(str);
//    Sys.exit();
    int start = str.indexOf("#4");
    start = str.indexOf("(", start) + 1;
    int end = str.indexOf(".dart:", start);
    end = str.indexOf(")", end + 1);
//    end = str.indexOf(":", end + 1);
    var frame = str.substring(start, end);
//    frame = frame.padLeft(100,' ');
    return frame;
  }

  ConsoleOut _console_out = new SystemOut();

  @override
  d(Object tag, [Object msg = NO_ARGUMENT]) {
    log(OUT_MODE.DEBUG, tag, msg);
  }

  @override
  e(Object tag, [Object msg = NO_ARGUMENT, Exception error, StackTrace stack]) {
    log(OUT_MODE.ERROR, tag, msg);
    if (error != null) {
      log(OUT_MODE.ERROR, tag, error);
    }
    if (stack != null) {
      log(OUT_MODE.ERROR, tag, stack);
    }
  }

  void _out(OUT_MODE mode, String frame, String msg) {
    if (_console_out == null) {
      if (mode == OUT_MODE.DEBUG) {
        print(msg);
      } else {
        print("ERROR: " + msg);
      }
    } else {
      _console_out.out(mode, frame, msg);
    }
  }

  void printList(OUT_MODE mode, String frame, String name, Iterable list) {
    String pf = "---[$name";
    _out(mode, frame, pf + "](" + list.length.toString() + ")---");

    for (int i = 0; i < list.length; i++) {
      String index = "[$i]";
      String space = spaces(pf.length - index.length);
      _out(mode, frame, space + index + " " + list.elementAt(i).toString());
    }
  }

  void printMap(OUT_MODE mode, String frame, String name, Map map) {
    String pf = "---[$name";
    _out(mode, frame, pf + "](" + map.length.toString() + ")---");
    int i = 0;
    Iterable keys = map.keys;
    for (var k in keys) {
      var v = map[k];
      String index = "[$i]";
      String space = spaces(pf.length - index.length);
      _out(mode, frame, space + index + " " + k.toString() + " :-> " + v.toString());
      i++;
    }
  }

  String spaces(n) => "".padLeft(n, ' ');

  void log(OUT_MODE mode, Object tag, Object msg) {
    String frame = getFrame();
    if (msg != NO_ARGUMENT) {
      if (msg is Iterable) {
        printList(mode, frame, tag, msg);
      } else if (msg is Map) {
        printMap(mode, frame, tag, msg);
      } else {
        _out(mode, frame, ": $tag > $msg");
      }
    } else {
      _out(mode, frame, ": $tag");
    }
  }
}

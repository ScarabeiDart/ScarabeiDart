import 'package:scarabei/api/lang/lang.dart';
import 'package:scarabei/api/log/logger.dart';


class SimpleLogger extends LoggerComponent {

  SimpleLogger([ConsoleOut out]) {
    _console_out = out;
  }

  ConsoleOut _console_out = null;

  @override
  d(Object tag, [Object msg = NO_ARGUMENT]) {
    if (msg != NO_ARGUMENT) {
      if (msg is Iterable) {
        printList(OUT_MODE.DEBUG, tag, msg);
      } else if (msg is Map) {
        printMap(OUT_MODE.DEBUG, tag, msg);
      } else {
        _out(OUT_MODE.DEBUG, ": $tag > $msg");
      }
    } else {
      _out(OUT_MODE.DEBUG, ": $tag");
    }
  }

  void _out(OUT_MODE mode, String msg) {
    if (_console_out == null) {
      if (mode == OUT_MODE.DEBUG) {
        print(msg);
      } else {
        print("ERROR: " + msg);
      }
    }
    else {
      _console_out.out(mode, msg);
    }
  }

  @override
  e(Object tag, [Object msg = NO_ARGUMENT]) {
    if (msg != NO_ARGUMENT) {
      _out(OUT_MODE.ERROR, ": $tag > $msg");
    } else {
      _out(OUT_MODE.ERROR, ": $tag");
    }
  }

  void printList(OUT_MODE mode, String name, Iterable list) {
    String pf = "---[$name";
    _out(mode, pf + "](" + list.length.toString() + ")---");

    for (int i = 0; i < list.length; i++) {
      String index = "[$i]";
      String space = spaces(pf.length - index.length);
      _out(mode, space + index + " " + list.elementAt(i).toString());
    }
  }

  void printMap(OUT_MODE mode, String name, Map map) {
    String pf = "---[$name";
    _out(mode, pf + "](" + map.length.toString() + ")---");
    int i = 0;
    Iterable keys = map.keys;
    for (var k in keys) {
      var v = map[k];
      String index = "[$i]";
      String space = spaces(pf.length - index.length);
      _out(mode, space + index + " " + k + " :-> " + v);
      i++;
    }
  }


  String spaces(n) => new List.filled(n + 1, ' ').join();
}

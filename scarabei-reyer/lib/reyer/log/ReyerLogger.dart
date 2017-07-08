import 'package:scarabei_api/lang/NO_ARG.dart';
import 'package:scarabei_api/log/Logger.dart';


abstract class ReyerLogger extends LoggerComponent {


  @override
  d(Object tag, [Object msg = NO_ARGUMENT]) {
    String TAG = "D";
    if (msg != NO_ARGUMENT) {
      _out(TAG + ": $tag > $msg");
    } else {
      _out(TAG + ": $tag");
    }
  }

  void _out(String msg) {
    print(msg);
  }

  @override
  e(Object tag, [Object msg = NO_ARGUMENT]) {
    String TAG = "E";
    if (msg != NO_ARGUMENT) {
      _out(TAG + ": $tag > $msg");
    } else {
      _out(TAG + ": $tag");
    }
  }
}


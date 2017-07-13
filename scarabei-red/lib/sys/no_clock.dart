library com.jfixby.scarabei.red.sys;

import 'package:scarabei_api/time/time_stream.dart';


class NoClock implements TimeStream {

  String toString() {
    return "NoTime[" + this.currentTimeMillis().toString() + "]";
  }

  int currentTimeMillis() {
    return 0;
  }
}

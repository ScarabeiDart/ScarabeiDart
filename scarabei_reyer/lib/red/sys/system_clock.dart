import 'package:scarabei/api/time/time_stream.dart';

class SystemClock implements TimeStream {

  String toString() {
    return "SystemTime[" + this.currentTimeMillis().toString() + "]";
  }

  int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}

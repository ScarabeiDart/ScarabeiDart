library com.jfixby.scarabei.red.sys;

import 'package:scarabei_api/api/log/logger.dart';
import 'package:scarabei_api/api/sys/system_info.dart';


class RedSystemInfo implements SystemInfo {
  Map<String, String> params = {};

  Map<String, String> listParameters() {
    return this.params;
  }

  void putValue(String key, Object value) {
    this.params[key] = "" + value;
  }

  void print() {
    L.d("---[DeviceInfo]------------------------");
    L.d("params", params);
  }

  void putAll(Map<String, String> other) {
    this.params.addAll(other);
  }
}

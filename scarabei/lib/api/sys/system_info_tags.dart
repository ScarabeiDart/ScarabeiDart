library com.jfixby.scarabei.api.sys;

import 'package:scarabei/api/names/names.dart';

class SystemInfoTags {
  static ID System_OS_NAME = Names.newID(string: "os.name");
  static ID System_OS_VERSION = Names.newID(string: "os.version");

  static ID Java_Version = Names.newID(string: "java.version");
  static ID Java_MaxHeapSize = Names.newID(string: "java.heap.max");
  static ID Java_RecommendedHeapSize = Names.newID(string: "java.heap.recommended");

  static ID Net_client_ip = Names.newID(string: "net.client_ip");

  static ID Desktop_Screen_WIDTH = Names.newID(string: "desktop.screen.width");
  static ID Desktop_Screen_HEIGHT = Names.newID(string: "desktop.screen.height");
}

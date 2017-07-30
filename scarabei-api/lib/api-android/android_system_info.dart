import 'package:scarabei_api/api/sys/system_info.dart';

abstract class AndroidSystemInfo extends SystemInfo {
  static String Brand = "android.brand";
  static String Model = "android.model";
  static String Host = "android.host";
  static String Serial = "android.serial";
  static String Release = "android.release";
  static String Fingerprint = "android.fingerprint";
  static String Manufacturer = "android.manufacturer";

  static String Display_WIDTH = "android.display.width";
  static String Display_HEIGHT = "android.display.height";

  static String App_Version_Name = "android.app.version.name";
  static String App_Version_Code = "android.app.version.code";
  static String App_Version_PackageName = "android.app.version.package_name";
}


import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/system_info.dart';

abstract class AndroidSystemInfoTags extends SystemInfo {
  static ID Brand = Names.newID(raw_id_string: "android.brand");
  static ID Model = Names.newID(raw_id_string: "android.model");
  static ID Host = Names.newID(raw_id_string: "android.host");
  static ID Serial = Names.newID(raw_id_string: "android.serial");
  static ID Release = Names.newID(raw_id_string: "android.release");
  static ID Fingerprint = Names.newID(raw_id_string: "android.fingerprint");
  static ID Manufacturer = Names.newID(raw_id_string: "android.manufacturer");

  static ID Display_WIDTH = Names.newID(raw_id_string: "android.display.width");
  static ID Display_HEIGHT = Names.newID(raw_id_string: "android.display.height");

  static ID App_Version_Name = Names.newID(raw_id_string: "android.app.version.name");
  static ID App_Version_Code = Names.newID(raw_id_string: "android.app.version.code");
  static ID App_Version_PackageName = Names.newID(raw_id_string: "android.app.version.package_name");
}

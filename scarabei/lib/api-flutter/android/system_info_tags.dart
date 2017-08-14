import 'package:scarabei/api/names/names.dart';

abstract class AndroidSystemInfoTags {
  static ID Brand = Names.newID(string: "android.brand");
  static ID Model = Names.newID(string: "android.model");
  static ID Host = Names.newID(string: "android.host");
  static ID Serial = Names.newID(string: "android.serial");
  static ID Release = Names.newID(string: "android.release");
  static ID Fingerprint = Names.newID(string: "android.fingerprint");
  static ID Manufacturer = Names.newID(string: "android.manufacturer");

  static ID Display_WIDTH = Names.newID(string: "android.display.width");
  static ID Display_HEIGHT = Names.newID(string: "android.display.height");

  static ID App_Version_Name = Names.newID(string: "android.app.version.name");
  static ID App_Version_Code = Names.newID(string: "android.app.version.code");
  static ID App_Version_PackageName = Names.newID(string: "android.app.version.package_name");
}

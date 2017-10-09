import 'package:scarabei/api/names/names.dart';

abstract class AndroidSystemInfoTags {
  static final ID Brand = Names.newID(string: "android.brand");
  static final ID Model = Names.newID(string: "android.model");
  static final ID Host = Names.newID(string: "android.host");
  static final ID Serial = Names.newID(string: "android.serial");
  static final ID Release = Names.newID(string: "android.release");
  static final ID Fingerprint = Names.newID(string: "android.fingerprint");
  static final ID Manufacturer = Names.newID(string: "android.manufacturer");

  static final ID Display_WIDTH = Names.newID(string: "android.display.width");
  static final ID Display_HEIGHT = Names.newID(string: "android.display.height");

  static final ID App_Version_Name = Names.newID(string: "android.app.version.name");
  static final ID App_Version_Code = Names.newID(string: "android.app.version.code");
  static final ID App_Version_PackageName = Names.newID(string: "android.app.version.package_name");
}

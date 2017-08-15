import 'package:scarabei/api/names/names.dart';

abstract class MobileSystemInfoTags {
  static final ID Brand = Names.newID(string: "mobile.device.brand");
  static final ID Model = Names.newID(string: "mobile.device.model");
  static final ID Host = Names.newID(string: "mobile.device.host");
  static final ID Serial = Names.newID(string: "mobile.device.serial");
  static final ID Release = Names.newID(string: "mobile.device.release");
  static final ID Fingerprint = Names.newID(string: "mobile.device.fingerprint");
  static final ID Manufacturer = Names.newID(string: "mobile.device.manufacturer");

  static final ID Display_WIDTH = Names.newID(string: "mobile.device.display.width");
  static final ID Display_HEIGHT = Names.newID(string: "mobile.device.display.height");

  static final ID App_Version_Name = Names.newID(string: "mobile.device.app.version.name");
  static final ID App_Version_Code = Names.newID(string: "mobile.device.app.version.code");
  static final ID App_Version_PackageName = Names.newID(string: "mobile.device.app.version.package_name");
}

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/names/names.dart';

class Version {
  static final ID AppVersionName = Names.newID(string: "app.version.name");
  static final ID AppVersionCode = Names.newID(string: "app.version.code");
  static final ID AppPackageName = Names.newID(string: "app.version.package_name");

  static String VERSION_FILE_NAME = "version.json";

  static int serialVersionUID = 6662721574596241247;

  String packageName;

  String major = "";
  String minor = "";
  String build = "";
  int versionCode = -1;

  String getVersionString() {
    Debug.checkNull("packageName", this.packageName);
    Debug.checkEmpty("packageName", this.packageName);
    Debug.checkEmpty("major is invalid", this.major);
    Debug.checkEmpty("minor is invalid", this.minor);
    Debug.checkEmpty("build is invalid ", this.build);
    Debug.checkNull("major is invalid", this.major);
    Debug.checkNull("minor is invalid", this.minor);
    Debug.checkNull("build is invalid ", this.build);
    return this.major + "." + this.minor + "." + this.build;
  }

  String getPackageVersionString() {
    return this.packageName + "-" + this.getVersionString() + " (versionCode: " + this.versionCode.toString() + ")";
  }
}

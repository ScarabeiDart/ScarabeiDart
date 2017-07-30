import 'package:scarabei_api/api/debug/debug.dart';

class Version {


  static String AppVersionName = "app.version.name";
  static String AppVersionCode = "app.version.code";
  static String AppPackageName = "app.version.package_name";

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

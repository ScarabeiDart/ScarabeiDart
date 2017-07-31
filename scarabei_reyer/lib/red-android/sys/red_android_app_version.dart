import 'package:scarabei/api-android/android_app_version.dart';
import 'package:scarabei/api/names/names.dart';


//import com.jfixby.scarabei.android.api.AndroidAppVersion;
//import com.jfixby.scarabei.api.assets.ID;
//import com.jfixby.scarabei.api.assets.Names;

class RedAndroidAppVersion implements AndroidAppVersion {

  int code = 0;
  String name;
  String package_name;


  String getName() {
    return this.name;
  }


  int getCode() {
    return this.code;
  }


  ID getPackageName() {
    return Names.newID(raw_id_string: this.package_name);
  }

}
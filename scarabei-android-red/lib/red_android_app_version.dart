import 'package:scarabei_android_api/android_app_version.dart';
import 'package:scarabei_api/names/id.dart';
import 'package:scarabei_api/names/names.dart';


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

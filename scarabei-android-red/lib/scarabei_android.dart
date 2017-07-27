import 'package:scarabei_android_api/android.dart';
import 'package:scarabei_android_red/filesystem/android_file_system.dart';
import 'package:scarabei_android_red/memory/android_memory_manager.dart';
import 'package:scarabei_android_red/red_android_component.dart';
import 'package:scarabei_android_red/sys/red_android_system.dart';
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/md5/md5.dart';
import 'package:scarabei_api/memory/memory_manager.dart';
import 'package:scarabei_api/strings/strings.dart';
import 'package:scarabei_api/sys/execution_mode.dart';
import 'package:scarabei_api/sys/settings/system_settings.dart';
import 'package:scarabei_api/sys/sys.dart';
import 'package:scarabei_api/utils/jutils.dart';
import 'package:scarabei_red/debug/red_debug.dart';
import 'package:scarabei_red/error/red_error.dart';
import 'package:scarabei_red/log/red_logger.dart';
import 'package:scarabei_red/md5/red_md5.dart';
import 'package:scarabei_red/strings/red_strings.dart';
import 'package:scarabei_red/sys/red_system_settings.dart';
import 'package:scarabei_red/utils/red_utils.dart';
import 'package:scarabei_red/json/red_json.dart';
import 'package:scarabei_api/json/json.dart';

class ScarabeiAndroid {

  static void deploy(AndroidComponent android) {
    L.installComponent(new RedLogger()); //logger
    Err.installComponent(new RedError()); //errors reporter
    Debug.installComponent(new RedDebug()); // asserts for debug and testing
    Utils.installComponent(new RedUtils()); //utils including the path-factory
//
        {
      LocalFileSystem.installComponent(new AndroidFileSystem());

      //This was the last line where we cared about the filesystem type (PISIX/Windows)
      //From this moment onwards, the path works in a generic way.
    }
//
//
    Json.installComponent(new RedJson());
    Strings.installComponent(new RedStrings()); // some utils for strings
    Sys.installComponent(new RedAndroidSystem()); //...
    SystemSettings.installComponent(new RedSystemSettings()); //...
    SystemSettings.setExecutionMode(ExecutionMode.EARLY_DEVELOPMENT); // activate debugging flags
//  SystemSettings.setExecutionMode(ExecutionMode.PUBLIC_RELEASE); // deactivate production mode
//    Application app = null;
    Android.installComponent(new RedAndroidComponent(null));
//
//


//		JUtils.installComponent(new RedJUtils());
//		Collections.installComponent(new AndroidCollections());
//		FloatMath.installComponent(new AndroidFloatMath());
//		TaskManager.installComponent(new RedTaskManager());
    Sys.installComponent(new RedAndroidSystem());
    SystemSettings.installComponent(new RedSystemSettings());
//		IntegerMath.installComponent(new RedIntegerMath());
//    Names.installComponent(new RedAssetsNamespace());
//		IO.installComponent(new RedIO());
//		Graphs.installComponent(new RedGraphs());

//		Angles.installComponent(new RedAngles());
//		Geometry.installComponent(new RedGeometry());
//		Colors.installComponent(new RedColors());
//		MathTools.installComponent(new RedMathTools());


    Android.installComponent(android);
    MemoryManager.installComponent(new AndroidMemoryManager());
//    L.d("Max heap size: ", MemoryManager.getMaxHeapSize().toString() + "Mb");
//    L.d("Recommended heap size: ", MemoryManager.getRecommendedHeapSize().toString() + "Mb");


    MD5.installComponent(new RedMD5());
//		Random.installComponent(new RedRandom());


//		Http.installComponent(new AndroidHttp());

//		ImageProcessing.installComponent(new RedImageProcessing());
//		FileCache.installComponent(new RedFileCache());
    L.d("ScarabeiAndroid deployed");
  }


}

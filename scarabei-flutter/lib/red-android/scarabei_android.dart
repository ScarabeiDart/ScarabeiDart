import 'package:scarabei_api/api-android/android.dart';
import 'package:scarabei_api/api/debug/debug.dart';
import 'package:scarabei_api/api/error/err.dart';
import 'package:scarabei_api/api/files/local_file_system.dart';
import 'package:scarabei_api/api/json/json.dart';
import 'package:scarabei_api/api/log/logger.dart';
import 'package:scarabei_api/api/md5/md5.dart';
import 'package:scarabei_api/api/memory/memory_manager.dart';
import 'package:scarabei_api/api/strings/strings.dart';
import 'package:scarabei_api/api/sys/execution_mode.dart';
import 'package:scarabei_api/api/sys/settings/system_settings.dart';
import 'package:scarabei_api/api/sys/sys.dart';
import 'package:scarabei_api/api/utils/utils.dart';
import 'package:scarabei_api/red-android/filesystem/android_file_system.dart';
import 'package:scarabei_api/red-android/memory/android_memory_manager.dart';
import 'package:scarabei_api/red-android/sys/red_android_system.dart';
import 'package:scarabei_api/red/debug/red_debug.dart';
import 'package:scarabei_api/red/error/red_error.dart';
import 'package:scarabei_api/red/json/dart_json.dart';
import 'package:scarabei_api/red/log/red_logger.dart';
import 'package:scarabei_api/red/md5/red_md5.dart';
import 'package:scarabei_api/red/strings/red_strings.dart';
import 'package:scarabei_api/red/sys/red_system_settings.dart';
import 'package:scarabei_api/red/utils/red_utils.dart';
import 'package:scarabei_flutter/red-android/sys/red_android_component.dart';

class ScarabeiAndroid {

  static void deploy() {
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
    Json.installComponent(new DartJson());
    Strings.installComponent(new RedStrings()); // some utils for strings
    Sys.installComponent(new RedAndroidSystem()); //...
    SystemSettings.installComponent(new RedSystemSettings()); //...
    SystemSettings.setExecutionMode(ExecutionMode.EARLY_DEVELOPMENT); // activate debugging flags
//  SystemSettings.setExecutionMode(ExecutionMode.PUBLIC_RELEASE); // deactivate production mode
//    Application app = null;
    MD5.installComponent(new RedMD5());
//
//


//		JUtils.installComponent(new RedJUtils());
//		Collections.installComponent(new AndroidCollections());
//		FloatMath.installComponent(new AndroidFloatMath());
//		TaskManager.installComponent(new RedTaskManager());
//		IntegerMath.installComponent(new RedIntegerMath());
//    Names.installComponent(new RedAssetsNamespace());
//		IO.installComponent(new RedIO());
//		Graphs.installComponent(new RedGraphs());

//		Angles.installComponent(new RedAngles());
//		Geometry.installComponent(new RedGeometry());
//		Colors.installComponent(new RedColors());
//		MathTools.installComponent(new RedMathTools());


    Android.installComponent(new RedAndroidComponent());
    MemoryManager.installComponent(new AndroidMemoryManager());
//    L.d("Max heap size: ", MemoryManager.getMaxHeapSize().toString() + "Mb");
//    L.d("Recommended heap size: ", MemoryManager.getRecommendedHeapSize().toString() + "Mb");



//		Random.installComponent(new RedRandom());


//		Http.installComponent(new AndroidHttp());

//		ImageProcessing.installComponent(new RedImageProcessing());
//		FileCache.installComponent(new RedFileCache());
    L.d("ScarabeiAndroid deployed");
  }


}

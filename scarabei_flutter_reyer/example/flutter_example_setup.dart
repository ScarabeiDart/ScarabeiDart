import 'package:scarabei/api-flutter/mobile_device.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/local_file_system.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/md5/md5.dart';
import 'package:scarabei/api/memory/memory_manager.dart';
import 'package:scarabei/api/strings/strings.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei/api/utils/utils.dart';
import 'package:scarabei_flutter_reyer/red-flutter/proxy/mobile_device.dart';
import 'package:scarabei_reyer/red-flutter/filesystem/file_system.dart';
import 'package:scarabei_reyer/red-flutter/flutter_system.dart';
import 'package:scarabei_reyer/red-flutter/memory/memory_manager.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/json/dart_json.dart';
import 'package:scarabei_reyer/red/log/simple_logger.dart';
import 'package:scarabei_reyer/red/md5/red_md5.dart';
import 'package:scarabei_reyer/red/strings/red_strings.dart';
import 'package:scarabei_reyer/red/utils/red_utils.dart';

class ScarabeiAndroid {

  static void deploy() {
    L.installComponent(new SimpleLogger()); //logger
    Err.installComponent(new RedError()); //errors reporter
    Debug.installComponent(new RedDebug()); // asserts for debug and testing
    Utils.installComponent(new RedUtils()); //utils including the path-factory

//
        {
      LocalFileSystem.installComponent(new FlutterFileSystem());

      //This was the last line where we cared about the filesystem type (PISIX/Windows)
      //From this moment onwards, the path works in a generic way.
    }
//
//
    Json.installComponent(new DartJson());
    Strings.installComponent(new RedStrings()); // some utils for strings
    Sys.installComponent(new FlutterSystem()); //...
//    SystemSettings.installComponent(new RedSystemSettings()); //...
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


    MobileDevice.installComponent(new MobileDeviceFlutterProxy());
    MemoryManager.installComponent(new FlutterMemoryManager());
//    L.d("Max heap size: ", MemoryManager.getMaxHeapSize().toString() + "Mb");
//    L.d("Recommended heap size: ", MemoryManager.getRecommendedHeapSize().toString() + "Mb");



//		Random.installComponent(new RedRandom());


//		Http.installComponent(new AndroidHttp());

//		ImageProcessing.installComponent(new RedImageProcessing());
//		FileCache.installComponent(new RedFileCache());
    L.d("ScarabeiAndroid deployed");
  }


}

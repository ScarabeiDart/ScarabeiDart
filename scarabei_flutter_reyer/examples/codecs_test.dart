import 'dart:async';

import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/cross-platform/transport.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/local_file_system.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/memory/memory_manager.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/strings/strings.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei/api/utils/utils.dart';
import 'package:scarabei_flutter_reyer/red-flutter/cross_platform_calls.dart';
import 'package:scarabei_reyer/red-flutter/filesystem/file_system.dart';
import 'package:scarabei_reyer/red-flutter/flutter_system.dart';
import 'package:scarabei_reyer/red-flutter/memory/memory_manager.dart';
import 'package:scarabei_reyer/red/codecs/red_codecs.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/json/dart_json.dart';
import 'package:scarabei_reyer/red/log/pub_logging.dart';
import 'package:scarabei_reyer/red/log/simple_logger.dart';
import 'package:scarabei_reyer/red/names/domain_names.dart';
import 'package:scarabei_reyer/red/strings/red_strings.dart';
import 'package:scarabei_reyer/red/utils/red_utils.dart';

main() async {
  PubLogging logging = new PubLogging();
//  logging.setupRootListener(PubLogging.combatDebug);
  logging.setupRootListener(PubLogging.simpleOutput);
  L.installComponent(new SimpleLogger(logging));
  Err.installComponent(new RedError()); //errors reporter
  Debug.installComponent(new RedDebug()); // explicit check and detailed exception
//  Debug.installComponent(new AssertionsChecker()); // uses assert()
  Utils.installComponent(new RedUtils()); //utils including the path-factory
  Names.installComponent(new DomainNames());

  Codecs.installComponent(new RedCodecs());

  LocalFileSystem.installComponent(new FlutterFileSystem());
  Json.installComponent(new DartJson());
  Strings.installComponent(new RedStrings()); // some utils for strings
  Sys.installComponent(new FlutterSystem()); //...

  MemoryManager.installComponent(new FlutterMemoryManager());

  L.d("ScarabeiDart deployed");

  CrossPlatformCalls.installComponent(new FlutterCrossPlatformCalls(new FakeTransport()));

  var specs = CrossPlatformCalls.newCallSpecs();
  specs.addArgument("x", 1);
  specs.addArgument("y", 3);
  specs.addArgument("z", ExecutionMode.EARLY_DEVELOPMENT);
  specs.addArgument("s", false);
  specs.addArgument("N", "null");
  specs.addArgument("L", [1, 2, 3, "S", null]);
  specs.addArgument("LL", [
    ['a', 's', 'd', null],
    ExecutionMode.EARLY_DEVELOPMENT,
    Names.newID(raw_id_string: "abc.de"),
    "S",
    null
  ]);
  specs.addArgument("id", Names.newID(raw_id_string: "abc.def.ghk"));
  specs.callID = Names.newID(raw_id_string: "abc.def.ght");
  Future<CallResult> callResult = CrossPlatformCalls.makeCall(specs);

  CallResult result = await callResult;
  L.d("result.success", result.success);
  L.d("result.errorMessage", result.errorMessage);
  L.d("result.resultingObject", result.resultingObject);
}

class FakeTransport implements Transport {
  @override
  Future<dynamic> invokeMethod(String name, Map<String, dynamic> arguments) async{
    L.d("call", name);
    L.d("arguments", arguments);
    return testString;
  }
  static String testString = '{  "type": "Map",  "value": [    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "desktop.screen.width"      },      {        "type": "String",        "value": "1920.0"      }    ],    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "desktop.screen.height"      },      {        "type": "String",        "value": "1080.0"      }    ],    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "os.name"      },      {        "type": "String",        "value": "Windows 8.1"      }    ],    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "java.version"      },      {        "type": "String",        "value": "1.8.0_131"      }    ],    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "app.version.package_name"      },      {        "type": "String",        "value": ""      }    ],    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "app.version.code"      },      {        "type": "String",        "value": ""      }    ],    [      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "app.version.name"      },      {        "type": "String",        "value": ""      }    ],    [      {        "type": "String",        "value": "ki"      },      {        "type": "int64",        "value": 5      }    ],    [      {        "type": "String",        "value": "kf"      },      {        "type": "double",        "value": 6.0      }    ],    [      {        "type": "String",        "value": "ks"      },      {        "type": "String",        "value": "asdasd"      }    ],    [      {        "type": "String",        "value": "kID"      },      {        "type": "com.jfixby.scarabei.api.names.ID",        "value": "asdasd.adasd"      }    ],    [      {        "type": "String",        "value": "Null"      },      {        "type": "Null"      }    ],    [      {        "type": "String",        "value": "L"      },      {        "type": "List",        "value": [          {            "type": "int64",            "value": 1          },          {            "type": "int64",            "value": 2          },          {            "type": "com.jfixby.scarabei.api.sys.settings.ExecutionMode",            "value": "DEMO"          },          {            "type": "Null"          },          {            "type": "String",            "value": "asd"          }        ]      }    ]  ]}';
}

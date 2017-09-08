import 'dart:async';

import 'package:scarabei/api/cross-platform/transport.dart';
import 'package:scarabei/api/log/logger.dart';

class FakeTransport implements Transport {
  @override
  Future<dynamic> invokeMethod(String name, Map<String, dynamic> arguments) async {
    L.d("call", name);
    L.d("arguments", arguments);
    return testString;
  }

  static String testString =
      '{  "type": "MethodCallResult",  "value": {    "result": {      "type": "Map",      "value": [        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "desktop.screen.width"          },          {            "type": "String",            "value": "1920.0"          }        ],        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "desktop.screen.height"          },          {            "type": "String",            "value": "1080.0"          }        ],        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "os.name"          },          {            "type": "String",            "value": "Windows 8.1"          }        ],        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "java.version"          },          {            "type": "String",            "value": "1.8.0_131"          }        ],        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "app.version.package_name"          },          {            "type": "String",            "value": ""          }        ],        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "app.version.code"          },          {            "type": "String",            "value": ""          }        ],        [          {            "type": "com.jfixby.scarabei.api.names.ID",            "value": "app.version.name"          },          {            "type": "String",            "value": ""          }        ]      ]    },    "success": {      "type": "Bool",      "value": true    },    "error": {      "type": "Null"    }  }}';
}
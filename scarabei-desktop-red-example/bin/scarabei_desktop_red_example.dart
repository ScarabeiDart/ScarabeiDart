// Copyright (c) 2017, JCode. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_red/debug/red_debug.dart';
import 'package:scarabei_red/error/red_error.dart';
import 'package:scarabei_red/log/red_logger.dart';

main() {
  L.installComponent(new RedLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());


  L.d("Hello!");
  L.d("Hello", "fuck you");

  Debug.checkNull("ssss");
//  Debug.checkNull(null, "x");

  Debug.checkTrue(false, "b");
}





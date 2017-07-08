// Copyright (c) 2017, JCode. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_reyer/reyer/debug/reyer_debug.dart';
import 'package:scarabei_reyer/reyer/error/reyer_error.dart';
import 'package:scarabei_reyer/reyer/log/reyer_logger.dart';

main() {
  L.installComponent(new ReyerLogger());
  Err.installComponent(new ReyerError());
  Debug.installComponent(new ReyerDebug());


  L.d("Hello!");
  L.d("Hello", "fuck you");

  Debug.checkNull("ssss");
//  Debug.checkNull(null, "x");

  Debug.checkTrue(false, "b");
}

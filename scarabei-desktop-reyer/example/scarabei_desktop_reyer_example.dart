// Copyright (c) 2017, JCode. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:scarabei_api/debug/Debug.dart';
import 'package:scarabei_api/error/Err.dart';
import 'package:scarabei_api/log/Logger.dart';
import 'package:scarabei_reyer/reyer/debug/ReyerDebug.dart';
import 'package:scarabei_reyer/reyer/error/ReyerError.dart';
import 'package:scarabei_reyer/reyer/log/ReyerLogger.dart';

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

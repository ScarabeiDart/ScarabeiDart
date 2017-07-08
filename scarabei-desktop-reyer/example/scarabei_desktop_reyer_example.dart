// Copyright (c) 2017, JCode. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:scarabei_api/debug/Error.dart';
import 'package:scarabei_api/log/Logger.dart';
import 'package:scarabei_desktop_reyer/reyer/log/DesktopReyerLogger.dart';
import 'package:scarabei_reyer/reyer/debug/ReyerError.dart';

main() {
  L.installComponent(new DesktopReyerLogger());
  Err.installComponent(new ReyerError());
  L.d("Hello!");
  L.d("Hello", "fuck you");
}

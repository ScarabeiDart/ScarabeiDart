// Copyright (c) 2017, JCode. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:scarabei_api/log/Logger.dart';
import 'package:scarabei_desktop_reyer/ReyerDesktopLogger.dart';
import 'package:scarabei_desktop_reyer/scarabei_desktop_reyer.dart';

main() {
  var awesome = new Awesome();
  print('awesome: ${awesome.isAwesome}');

  L.installComponent(new DesktopReyerLogger());

  L.d("Hello!");
  L.d("Hello", "fuck you");
}

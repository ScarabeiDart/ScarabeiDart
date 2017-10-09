import 'dart:io';

import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/red/sys/red_system.dart';

class DesktopSystem extends RedSystem {
  @override
  Map<ID, String> getSystemInfo() {
    final Map<ID, Object> deviceInfo = {};

    {
//      final Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
//      final double width = screenSize.getWidth();
//      final double height = screenSize.getHeight();
//      deviceInfo.put(SystemInfoTags.Desktop.Screen.WIDTH, width + "");
//      deviceInfo.put(SystemInfoTags.Desktop.Screen.HEIGHT, height + "");
    }

    {
//      final String osName = System.getProperty("os.name");
      final String osName = Platform.operatingSystem;
      deviceInfo[SystemInfoTags.System_OS_NAME] = osName;
    }
    {
//      final String java = System.getProperty("java.version");
//      deviceInfo.put(SystemInfoTags.Java.Version, java);
    }

    {
      deviceInfo[Version.AppPackageName] = SystemSettings.getStringParameter(Version.AppPackageName, defaultValue: "");
      deviceInfo[Version.AppVersionCode] = SystemSettings.getStringParameter(Version.AppVersionCode, defaultValue: "");
      deviceInfo[Version.AppVersionName] = SystemSettings.getStringParameter(Version.AppVersionName, defaultValue: "");
    }

    return deviceInfo;
  }
}

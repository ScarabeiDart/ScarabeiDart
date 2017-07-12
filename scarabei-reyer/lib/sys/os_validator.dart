import 'dart:io';

class OSValidator {

  OSValidator() {
  }
  static String OS = Platform.operatingSystem.toLowerCase();

  static bool isWindows() {
    return OS.indexOf("win") >= 0;
  }

  static bool isMac() {
    return OS.indexOf("mac") >= 0;
  }

  static bool isUnix() {
    return ((OS.indexOf("nix") >= 0) || (OS.indexOf("nux") >= 0)) || (OS.indexOf("aix") > 0);
  }

  static bool isSolaris() {
    return OS.indexOf("sunos") >= 0;
  }

  static bool isIOS() {
    return OS.indexOf("ios") >= 0;
  }

  static String getOS() {
    if (isWindows()) {
      return "win";
    } else {
      if (isMac()) {
        return "osx";
      } else {
        if (isUnix()) {
          return "uni";
        } else {
          if (isSolaris()) {
            return "sol";
          } else {
            return "err";
          }
        }
      }
    }
  }
}

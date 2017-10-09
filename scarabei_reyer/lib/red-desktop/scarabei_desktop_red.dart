import 'package:logging/logging.dart';
import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

class ScarabeiDesktop {
  static void deploy() {
    Logger.root.onRecord.listen(loggerListener);

    Utils.installComponent(new RedUtils()); //utils including the path-factory
    Names.installComponent(new DomainNames());
    PubLogging logging = new PubLogging();
    L.installComponent(new SimpleLogger(logging));
    Err.installComponent(new RedError()); //errors reporter
    Debug.installComponent(new RedDebug()); // explicit check and detailed exception
//  Debug.installComponent(new AssertionsChecker()); // uses assert()

    Codecs.installComponent(new RedCodecs());

    LocalFileSystem.installComponent(new WinFileSystem());
    Json.installComponent(new DartJson());
    Strings.installComponent(new RedStrings()); // some utils for strings
    Sys.installComponent(new DesktopSystem()); //...

    SystemSettings.installComponent(new RedSystemSettings()); //...
    SystemSettings.setExecutionMode(ExecutionMode.DEMO);
  }

  static int logPadding = 0;

  static void loggerListener(LogRecord record) {
    int localLogPadding = logPadding;
    if (SystemSettings.component() == null) {
      localLogPadding = 0;
    } else if (SystemSettings.getExecutionMode().isBelow(ExecutionMode.TESTING)) {
      localLogPadding = 0;
    }
    String splitter = "| ";
    var left = (record.level.toString() + " " + record.loggerName.toString()).padLeft(localLogPadding, ' ');

    if (SystemSettings.component() == null) {
//      splitter = "";
      left = "";
    } else if (SystemSettings.getExecutionMode().isBelow(ExecutionMode.TESTING)) {
      left = "";
//      splitter = "";
    }
    List<String> list = record.message.split("\n");
    for (int i = 0; i < list.length; i++) {
      print(left + splitter + list[i]);
      if (i == 0) {
        left = "".padLeft(left.length, ' ');
      }
    }
    if (record.error != null) {
      print(record.error.toString());
    }
    if (record.stackTrace != null) {
      print(record.stackTrace.toString());
    }
  }
}

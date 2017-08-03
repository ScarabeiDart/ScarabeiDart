import 'package:logging/logging.dart';
import 'package:scarabei/api/log/logger.dart';

//https://pub.dartlang.org/packages/logging
class PubLogging implements ConsoleOut {
  final Map<String, _Logger> registry = {};
  int _sizeLimit = 100;

  PubLogging() {
    hierarchicalLoggingEnabled = true;
  }

  _Logger obtainLogger(String name) {
    _Logger logger = registry[name];
    if (logger == null) {
      logger = new _Logger(name);

      registry[name] = logger;
    }

    if (registry.length > _sizeLimit) {
      registry.clear();
      registry[name] = logger;
    }
    return logger;
  }

  @override
  void out(OUT_MODE mode, String frame, String msg) {
    _Logger logger = obtainLogger(frame);
    if (mode == OUT_MODE.DEBUG) {
      logger.info(msg);
    } else {
      logger.warning(msg);
    }
  }

  void setupRootListener(Function loggerListener) {
    Logger.root.onRecord.listen(loggerListener);
  }
}

class _Logger {
  Logger log;

  _Logger(String name) {
    log = new Logger(name);
    log.level = Level.ALL;
  }

  void info(String message) {
    log.info(message);
  }

  void warning(String message) {
    log.warning(message);
  }
}

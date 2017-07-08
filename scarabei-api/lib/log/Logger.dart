import 'package:scarabei_api/ComponentInstaller.dart';
import 'package:scarabei_api/lang/NO_ARG.dart';


class L {

  static ComponentInstaller<
      LoggerComponent> _componentInstaller = new ComponentInstaller<
      LoggerComponent>("Logger");


  static void installComponent(LoggerComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static LoggerComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static LoggerComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static LoggerComponent component() {
    return _componentInstaller.getComponent();
  }

  static d(Object tag, [Object msg = NO_ARGUMENT]) {
    invoke().d(tag, msg);
  }

  static e(Object tag, [Object msg = NO_ARGUMENT]) {
    invoke().e(tag, msg);
  }

}

abstract class LoggerComponent {

  d(Object tag, [Object msg = NO_ARGUMENT]); //debug

  e(Object tag, [Object msg = NO_ARGUMENT]); //error

}
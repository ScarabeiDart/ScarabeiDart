import 'package:scarabei_api/api/camera/camera.dart';
import 'package:scarabei_api/api/component_installer.dart';



class Cameras {
  static ComponentInstaller<CamerasComponent> _componentInstaller = new ComponentInstaller<CamerasComponent>("Camera");

  static void installComponent(CamerasComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static CamerasComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static CamerasComponent component() {
    return _componentInstaller.getComponent();
  }

  static void register(Camera camera) {
    invoke().register(camera);
  }

}

abstract class CamerasComponent {

  void register(Camera camera);

}

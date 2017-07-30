import 'package:scarabei/api/component_installer.dart';

class MemoryManager {
  static ComponentInstaller<MemoryManagerComponent> _componentInstaller = new ComponentInstaller<MemoryManagerComponent>(
      "MemoryManager");

  static void installComponent(MemoryManagerComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static MemoryManagerComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static MemoryManagerComponent component() {
    return _componentInstaller.getComponent();
  }

  static int getMaxHeapSize() {
    return invoke().getMaxHeapSize();
  }

  static int getRecommendedHeapSize() {
    return invoke().getRecommendedHeapSize();
  }

}

abstract class MemoryManagerComponent {

  int getMaxHeapSize();

  int getRecommendedHeapSize();

}


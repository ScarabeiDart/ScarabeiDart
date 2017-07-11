import 'package:scarabei_api/component_installer.dart';

class Collections {

  static ComponentInstaller<
      CollectionsComponent> _componentInstaller = new ComponentInstaller<
      CollectionsComponent>("Collections");


  static void installComponent(CollectionsComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static CollectionsComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static CollectionsComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static CollectionsComponent component() {
    return _componentInstaller.getComponent();
  }

  // ignore: conflicting_dart_import
  static List<T> newList<T>() {
    return invoke().newList();
  }

  // ignore: conflicting_dart_import
  static Map<K, V> newMap<K, V>() {
    return invoke().newMap();
  }
}

abstract class CollectionsComponent {
  List<T> newList<T>();

  Map<K, V> newMap<K, V>();
}
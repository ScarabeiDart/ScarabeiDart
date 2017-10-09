import 'package:scarabei/scarabei.dart';

class MobileDeviceStub implements MobileDeviceComponent {
  final MobileAppVersion version = new MobileAppVersion();
  static String demoFolderName = "mobile-device-stub";

  @override
  MobileAppVersion getAppVersion() {
    return version;
  }

  @override
  String getApplicationPrivateDirPathString() {
    return LocalFileSystem.ApplicationHome().child(demoFolderName).child("private").toDartFile().path;
  }

  @override
  String getBrand() {
    return "stub-brand";
  }

  @override
  LocalFile getCacheFolder() {
    return LocalFileSystem.ApplicationHome().child(demoFolderName).child("cache");
  }

  @override
  LocalFile getPrivateFolder() {
    return LocalFileSystem.ApplicationHome().child(demoFolderName).child("private");
  }

  @override
  String getFingerPrint() {
    return "stub-fingerprint";
  }

  @override
  String getHost() {
    return "stub-host";
  }

  @override
  String getManufacturer() {
    return "stub-manufacturer";
  }

  @override
  int getMaxHeapSize() {
    return MemoryManager.getMaxHeapSize();
  }

  @override
  String getModel() {
    return "stub-model";
  }

  @override
  int getRecommendedHeapSize() {
    return MemoryManager.getRecommendedHeapSize();
  }

  @override
  String getSerial() {
    return "stub-serial";
  }

  @override
  Map<ID, Object> getSystemInfo() {
    return Sys.getSystemInfo();
  }

  @override
  String getVersionRelease() {
    return "stub-release";
  }
}

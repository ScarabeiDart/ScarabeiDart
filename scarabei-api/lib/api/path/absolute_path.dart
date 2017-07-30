import 'package:scarabei_api/api/path/mount_point.dart';
import 'package:scarabei_api/api/path/relative_path.dart';

abstract class AbsolutePath<T extends MountPoint> {

  T getMountPoint();

  RelativePath getRelativePath();

  AbsolutePath<T> child(String child_name);

  AbsolutePath<T> parent();

  AbsolutePath<T> proceed(RelativePath relative);

  String getName();

  bool isRoot();

  bool beginsWith<T extends MountPoint>(AbsolutePath<T> rootPath);
}
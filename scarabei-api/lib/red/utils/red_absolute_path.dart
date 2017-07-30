import 'package:scarabei_api/api/error/err.dart';
import 'package:scarabei_api/api/path/absolute_path.dart';
import 'package:scarabei_api/api/path/mount_point.dart';
import 'package:scarabei_api/api/path/relative_path.dart';
import 'package:scarabei_api/api/utils/utils.dart';

class RedAbsolutePath<T extends MountPoint> extends AbsolutePath<T> {

  T mount_point;
  RelativePath relative;

  RedAbsolutePath(T mount_point, [RelativePath relative]) {
    this.mount_point = mount_point;
    this.relative = relative;
    if (this.mount_point == null) {
      Err.reportError("MountPoint == null");
    }
    if (this.relative == null) {
      this.relative = Utils.newRelativePath();
    }
  }

  T getMountPoint() {
    return this.mount_point;
  }

  RelativePath getRelativePath() {
    return this.relative;
  }

  String getName() {
    Iterable<String> steps = this.relative.steps();
    if (steps.length == 0) {
      Err.reportError("This is root!");
    }
    return steps.lastWhere((x) => true);
  }

  AbsolutePath<T> child(String child_name) {
    RelativePath child_relative = this.relative.child(child_name);
    AbsolutePath result = Utils.newAbsolutePath(this.mount_point, child_relative);
    return result;
  }

  String toString() {
    return (("@[" + this.mount_point.toString()) + "] ") + this.relative.getPathString();
  }

  AbsolutePath<T> parent() {
    RelativePath parent = this.relative.parent();
    AbsolutePath result = Utils.newAbsolutePath(this.mount_point, parent);
    return result;
  }

  AbsolutePath<T> proceed(RelativePath relative) {
    RelativePath incremented = this.relative.proceed(relative);
    return Utils.newAbsolutePath(this.mount_point, incremented);
  }

  bool isRoot() {
    return this.relative.isRoot();
  }

  bool beginsWith<T extends MountPoint>(AbsolutePath<T> other) {
    if (!(this.mount_point == other.getMountPoint())) {
      return false;
    }
    return this.relative.beginsWith(other.getRelativePath());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RedAbsolutePath &&
              runtimeType == other.runtimeType &&
              mount_point == other.mount_point &&
              relative == other.relative;

  @override
  int get hashCode =>
      relative.hashCode;


}

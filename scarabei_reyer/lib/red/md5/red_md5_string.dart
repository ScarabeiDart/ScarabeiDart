import 'package:scarabei/api/md5/md5_string.dart';

class RedMD5String implements MD5String {

  RedMD5String(String string) {
    this.md5Hex = string.toLowerCase();
    String readable_md5 = "";
    for (int i = 0; i < this.md5Hex.length; (i = (i + 2))) {
      readable_md5 = ((readable_md5 + this.md5Hex[i]) + this.md5Hex[i + 1]);
      if ((i + 2) < this.md5Hex.length) {
        readable_md5 = (readable_md5 + ":");
      }
    }
    this.readable_md5 = readable_md5;
  }

  String toString() {
    return this.md5Hex;
  }

  String md5Hex;
  String readable_md5;


  String getMD5HashHexString() {
    return this.md5Hex;
  }

  String getHumanReadableMD5HashHexString() {
    return this.readable_md5;
  }
}
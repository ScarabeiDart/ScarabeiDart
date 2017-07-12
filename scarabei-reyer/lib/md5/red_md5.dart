import 'package:crypto/crypto.dart' as dart;
import 'package:crypto/src/digest.dart';
import 'package:scarabei_api/md5/md5.dart';
import 'package:scarabei_api/md5/md5_string.dart';
import 'package:scarabei_api/strings/strings.dart';
import 'package:scarabei_reyer/md5/red_md5_string.dart';

class RedMD5 implements MD5Component {
  @override
  MD5String md5String({String md5String}) {
    return new RedMD5String(md5String);
  }

  @override
  MD5String hashBytes({List<int> bytes}) {
    Digest result = dart.md5.convert(bytes);
    MD5String checksum = MD5.md5String(md5String: result.toString());
    return checksum;
  }

  @override
  MD5String hashString({String stringToHash}) {
    return this.hashBytes(bytes: Strings.toBytes(stringToHash));
  }
}


import 'package:scarabei_api/api/names/names.dart';

abstract class AndroidAppVersion {

  String getName();

  int getCode();

  ID getPackageName();
}

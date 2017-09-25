import 'package:scarabei/scarabei.dart';

abstract class ConnectionParametersProvider {
  String getHost();

  int getPort();

  String getLogin();

  String getPassword();

  ID getDBName();
}

import 'package:scarabei_api/log/Logger.dart';


abstract class ReyerLogger extends LoggerComponent {


  @override
  d(Object tag, [Object msg]) {
    print("D: $tag > $msg");
  }

  @override
  e(Object tag, [Object msg]) {
    ("E: $tag > $msg");
  }
}
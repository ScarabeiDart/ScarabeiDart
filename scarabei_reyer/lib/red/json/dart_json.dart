import 'dart:convert';

import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/json/json_string.dart';
import 'package:scarabei/api/log/logger.dart';

//import 'dart:convert';
class DartJson implements JsonComponent {
  @override
  dynamic deserializeFromString({JsonString json, String rawString}) {
    if (json != null) {
      rawString = json.toString();
    }
    dynamic result = JSON.decode(rawString);
    return result;
  }

  @override
  JsonString newJsonString(String raw_json_string) {
    return new RedJsonString(raw_json_string);
  }

  @override
  void printPretty(JsonString json_string) {
    L.d(json_string.toString());
  }

  @override
  JsonString serializeToString(Object object) {
    String raw = JSON.encode(object);
    var result = newJsonString(raw);
    return result;
  }
}

class RedJsonString implements JsonString {
  final String raw_json_string;

  RedJsonString(this.raw_json_string);

  toString() => raw_json_string;
}

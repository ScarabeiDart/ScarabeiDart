//package com.jfixby.scarabei.api.json;

//import com.jfixby.scarabei.api.ComponentInstaller;


import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/json/json_string.dart';

class Json {

  static ComponentInstaller<JsonComponent> componentInstaller = new ComponentInstaller<JsonComponent>("Json");

  static void installComponent(JsonComponent component_to_install) {
    componentInstaller.installComponent(component_to_install);
  }

  static JsonComponent invoke() {
    return componentInstaller.invokeComponent();
  }

  static JsonComponent component() {
    return componentInstaller.getComponent();
  }

  static JsonString serializeToString(Object object) {
    return invoke().serializeToString(object);
  }

  static dynamic deserializeFromString({JsonString json, String rawString}) {
    return invoke().deserializeFromString(json: json, rawString: rawString);
  }


  static void printPretty(JsonString json_string) {
    invoke().printPretty(json_string);
  }

  static JsonString newJsonString(String raw_json_string) {
    return invoke().newJsonString(raw_json_string);
  }
}

abstract class JsonComponent {

  JsonString serializeToString(Object object);

  dynamic deserializeFromString({JsonString json, String rawString});

  void printPretty(JsonString json_string);

  JsonString newJsonString(String raw_json_string);

}



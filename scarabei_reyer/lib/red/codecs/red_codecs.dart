import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/codec/to_dart_decoder.dart';
import 'package:scarabei_reyer/red/codecs/dart_primitives_decoder.dart';
import 'package:scarabei_reyer/red/codecs/dart_primitives_encoder.dart';
import 'package:scarabei_reyer/red/codecs/decoders.dart';
import 'package:scarabei_reyer/red/codecs/encoders.dart';
import 'package:scarabei_reyer/red/codecs/method_decoder.dart';
import 'package:scarabei_reyer/red/codecs/method_encoder.dart';
import 'package:scarabei_reyer/red/codecs/scarabei_encoder.dart';
import 'package:scarabei_reyer/red/codecs/to_scarabei_decoder.dart';

class RedCodecs implements CodecsComponent {
  Encoders encoders = new Encoders();
  Decoders decoders = new Decoders();

  RedCodecs() {
    this.registerDecoder(new DartPrimitivesDecoder());
    this.registerDecoder(new ScarabeiDecoder());
    this.registerDecoder(new MethodDecoder());



    this.registerEncoder(new ScarabeiEncoder());
    this.registerEncoder(new MethodEncoder());
    this.registerEncoder(new DartPrimitivesEncoder());
  }

  void registerEncoder(FromDartEncoder encoder) {
    this.encoders.register(encoder);
  }

  void registerDecoder(ToDartDecoder decoder) {
    this.decoders.registerDecoder(decoder);
  }

  Map<String, dynamic> encode(Object flutterObject) {
    return this.encoders.encode(flutterObject);
  }

  dynamic decode(Map<String, dynamic> encoded) {
    return this.decoders.decode(encoded);
  }
}

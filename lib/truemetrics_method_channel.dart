import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'truemetrics_platform_interface.dart';

/// An implementation of [TruemetricsPlatform] that uses method channels.
class MethodChannelTruemetrics extends TruemetricsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('truemetrics');
  final _eventChannel = const EventChannel("truemetrics_events");


  Future<String> initialize(String apiKey) async{
    return await methodChannel.invokeMethod<String>("init", apiKey) ?? "NOT WORKING";
  }
  Future<bool> startRecording()async{
    await methodChannel.invokeMethod<String>("startRecording");
    return true;
  }

  String startListening() {
    _eventChannel.receiveBroadcastStream().listen((event) {
     return event ?? "Null";
    }, onError: (error) {
      print("Error received from native code: $error");
      return "error";
    });
    return "Unknown";
  }

  Future<bool> stopRecording() async{
    await methodChannel.invokeMethod<String>("stopRecording");
    return true;
  }

  Future<bool> deinit()async{
    await methodChannel.invokeMethod<String>("deinit");
    return true;
  }

  void logMetaData(Map<String, String> data){
    methodChannel.invokeMethod("log", data);
  }




}

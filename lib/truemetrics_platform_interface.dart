import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'truemetrics_method_channel.dart';

abstract class TruemetricsPlatform extends PlatformInterface {
  /// Constructs a TruemetricsPlatform.
  TruemetricsPlatform() : super(token: _token);

  static final Object _token = Object();

  static TruemetricsPlatform _instance = MethodChannelTruemetrics();

  /// The default instance of [TruemetricsPlatform] to use.
  ///
  /// Defaults to [MethodChannelTruemetrics].
  static TruemetricsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TruemetricsPlatform] when
  /// they register themselves.
  static set instance(TruemetricsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> initialize(String apiKey){
    throw UnimplementedError("Is not initialized $apiKey");
  }

  Future<bool> startRecording(){
    throw UnimplementedError("Recording not started");
  }

  Future<bool> stopRecording(){
    throw UnimplementedError("Stop Recording");
  }


  String startListening() {
    throw UnimplementedError("Listner not implemented");
  }

  Future<bool> deinit(){
    throw UnimplementedError("Deinitialization not implemented");
  }
}

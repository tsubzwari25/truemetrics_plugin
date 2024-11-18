import 'package:flutter_test/flutter_test.dart';
import 'package:truemetrics/truemetrics.dart';
import 'package:truemetrics/truemetrics_platform_interface.dart';
import 'package:truemetrics/truemetrics_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTruemetricsPlatform
    with MockPlatformInterfaceMixin
    implements TruemetricsPlatform {

  @override
  Future<String> getPlatformVersion() => Future.value('42');

  @override

  Future<String> initialize(apikey) => Future.value("true");



  @override
  Future<bool> startRecording() {
    // TODO: implement startRecording
    throw UnimplementedError();
  }

  @override
  String startListening() {
    // TODO: implement startListening
    throw UnimplementedError("Not initialized");
  }

  @override
  Future<bool> deinit() {
    // TODO: implement deinit
    throw UnimplementedError();
  }

  @override
  Future<bool> stopRecording() {
    // TODO: implement stopRecording
    throw UnimplementedError();
  }
}

void main() {
  final TruemetricsPlatform initialPlatform = TruemetricsPlatform.instance;

  test('$MethodChannelTruemetrics is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTruemetrics>());
  });

  test('getPlatformVersion', () async {
    Truemetrics truemetricsPlugin = Truemetrics();
    MockTruemetricsPlatform fakePlatform = MockTruemetricsPlatform();
    TruemetricsPlatform.instance = fakePlatform;

    // expect(await truemetricsPlugin.getPlatformVersion(), '42');
  });
}

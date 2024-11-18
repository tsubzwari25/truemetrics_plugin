import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truemetrics/truemetrics_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTruemetrics platform = MethodChannelTruemetrics();
  const MethodChannel channel = MethodChannel('truemetrics');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

}

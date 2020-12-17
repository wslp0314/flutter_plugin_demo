import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wechat_web_login_plugin/wechat_web_login_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('wechat_web_login_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await WechatWebLoginPlugin.platformVersion, '42');
  });
}

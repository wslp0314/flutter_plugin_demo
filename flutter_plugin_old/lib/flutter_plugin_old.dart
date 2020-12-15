
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterPluginOld {

  //dart层监听事件
  StreamSubscription<dynamic> _eventSubscription;



  // initEvent() {
  //   //注册事件监听，设置event回调
  //   _eventSubscription = new EventChannel("flutter_plugin_old_event")
  //       .receiveBroadcastStream()
  //       .listen(
  //       eventData,
  //       onError: eventError,
  //       onDone: eventDone
  //   );
  // }

  /**
   *关闭并发送完成事件流，回调
   */
  void eventDone() {
    print("十秒钟后-------dart层接收到消息并打印出来");
    print("eventDone");
  }

  /**
   * 出错回调
   */
  void eventError(error) {
    print("eventError:$error");
  }

  /**
   * 接收数据回调
   */
  void eventData(event) {
    print("eventData:$event");
    final Map<dynamic, dynamic> map = event;
    switch (map ['event']) {
      case ' demoEvent':
        String value = map['value'];
        print('demo event data : $value');
        break;
      default:
        print("十秒钟后-------dart层接收到ios或者Android层的消息并打印出来");
        print(event);
        break;
    }
  }


    FlutterPluginOld () {
      initEvent();
  }

  initEvent (){
    //接收广播流( 接收 ios或者anroid层的  派发出的消息)
    _eventSubscription = new EventChannel("flutter_plugin_old_event")
        .receiveBroadcastStream()
        .listen(
        eventData,
        onError: eventError,
        onDone: eventDone
    );
  }


  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_old');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get changePageTitle async {
    final String title = await _channel.invokeMethod('changePageTitle');
    return title;
  }

  static Future<String> getAndPushValue(String message) async {

    final Map<dynamic,dynamic> map = await _channel.invokeMethod('getAndPushValue',
        <String,dynamic>{"message":message,"info":"chishiba"});
    String message1 = map["message"];
    String info = map["info"];
    print(message1);
    return info;
  }
}

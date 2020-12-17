
import 'dart:async';

import 'package:flutter/services.dart';

class WechatWebLoginPlugin {
  static const MethodChannel _channel =
      const MethodChannel('wechat_web_login_plugin');


  //dart层监听事件
  StreamSubscription<dynamic> _eventSubscription;

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


  WechatWebLoginPlugin () {
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

  static Future<String> getWechatInfo (String message) async {
    final String info = await _channel.invokeMethod('getWechatInfo',<String,dynamic>{"message":message});
    return info;
  }
}


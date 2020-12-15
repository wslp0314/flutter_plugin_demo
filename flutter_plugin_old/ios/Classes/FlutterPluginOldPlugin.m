#import "FlutterPluginOldPlugin.h"
#import "FlutterPluginOldPluginEvent.h"

@implementation FlutterPluginOldPlugin

FlutterPluginOldPluginEvent *pluginEvent;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_plugin_old"
                                     binaryMessenger:[registrar messenger]];
    FlutterPluginOldPlugin* instance = [[FlutterPluginOldPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    //注册ios原生  派发事件
    pluginEvent = [[FlutterPluginOldPluginEvent alloc] init];
    pluginEvent.eventChannel = [FlutterEventChannel
                                eventChannelWithName:@"flutter_plugin_old_event"
                                binaryMessenger:[registrar messenger]];
    [pluginEvent.eventChannel setStreamHandler:pluginEvent];
}



- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"changePageTitle" isEqualToString:call.method]) {
      result(@"我想干你皮炎");
  } else if ([@"getAndPushValue" isEqualToString:call.method]) {
      NSLog(@"苹果吞下了我一斤镜子 :::%@",call.arguments[@"message"]);
//      result(call.arguments[@"message"]);
//      result(@{
//              @"message" : @"易筋经自",
//              @"info" : @"ios :姜贞羽吃我的精子",
//             });
      
      //ios层开始  派发事件  发送数据
      FlutterEventSink eventSink = pluginEvent.eventSink;
      if (eventSink) {
          eventSink(@{
              @"message":@"ios层 ------ 姜贞羽  被我干的大汗淋漓",
              @"info":@"ios层 ------ 姜贞羽  被我干哭了"
                    });
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end

#import <Flutter/Flutter.h>

@interface WechatWebLoginPluginEvent : NSObject<FlutterStreamHandler>
@property (nonatomic, strong) FlutterEventSink eventSink;
@property (nonatomic, strong) FlutterEventChannel *eventChannel;
@end

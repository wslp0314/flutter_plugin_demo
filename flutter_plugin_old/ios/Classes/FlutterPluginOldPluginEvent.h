#import <Flutter/Flutter.h>

@interface FlutterPluginOldPluginEvent : NSObject<FlutterStreamHandler>
@property (nonatomic, strong) FlutterEventSink eventSink;
@property (nonatomic, strong) FlutterEventChannel *eventChannel;
@end

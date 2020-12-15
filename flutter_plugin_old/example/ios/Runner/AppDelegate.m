#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "WXApi.h"
#import "LPWechatLoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel *Wchannel =
    [FlutterMethodChannel methodChannelWithName:@"flutter_native" binaryMessenger:controller.binaryMessenger];
    [Wchannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult _Nonnull result) {
        NSLog(@"---->call.method=%@ \n call.arguments = %@", call.method, call.arguments);
        if([@"pushSquarePage"isEqualToString:call.method]) {
            LPWechatLoginViewController *vc1 = [LPWechatLoginViewController new];
            vc1.send = YES;
            [controller.navigationController pushViewController:vc1 animated:YES];
        }
    }];
    
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"oauth"]){//微信登录
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}



//实现微信回调。。
#pragma mark - WXDelegate
-(void)onResp:(BaseResp*)resp{
     if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp * res = (SendAuthResp*)resp;
       
        switch (resp.errCode) {
            case 0://用户同意
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChat_log_seuuess" object:nil userInfo:@{@"code":res.code}];
                });
            }
                break;
            case -4://用户拒绝授权
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChat_log_error" object:nil ];
                break;
            case -2://用户取消
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChat_log_error" object:nil ];
                break;
            default:
                break;
        }

    }

   }

@end

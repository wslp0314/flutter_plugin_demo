#import "WechatWebLoginPlugin.h"
#import "WXApi.h"

@implementation WechatWebLoginPlugin

FlutterResult _result;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"wechat_web_login_plugin"
            binaryMessenger:[registrar messenger]];
  WechatWebLoginPlugin* instance = [[WechatWebLoginPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    _result = result;
  if ([@"getWechatInfo" isEqualToString:call.method]) {
    
  } else {
    result(FlutterMethodNotImplemented);
  }
}


//发送登录请求
-(void)wechatLogin
{
    
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
    
    SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
    req.scope = @"snsapi_userinfo" ;
    req.state = @"同业人" ;
    req.openID = @"w**************";
//    [WXApi sendAuthReq:req viewController:[UIViewController new] delegate:self];
    
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

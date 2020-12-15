//
//  LPWechatLoginViewController.m
//  Runner
//
//  Created by 刘璞 on 2020/12/15.
//

#import "LPWechatLoginViewController.h"

@interface LPWechatLoginViewController ()

@end

@implementation LPWechatLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view.
}

//只有在页面加载完毕后才能调用微信登录。。。。
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.send) {
       [self wechatLogin];
    }
}

//发送登录请求
-(void)wechatLogin {
    SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
    req.scope = @"snsapi_userinfo" ;
    req.state = @"同业人" ;
    req.openID = @"wx33bf7ed33164f03d";
    self.send = YES;
    if ([WXApi isWXAppInstalled])
    {
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else
    {
        [WXApi sendAuthReq:req viewController:self delegate:self completion:^(BOOL success) {
            
        }];
    }
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

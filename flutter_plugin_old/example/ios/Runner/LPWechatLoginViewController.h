//
//  LPWechatLoginViewController.h
//  Runner
//
//  Created by 刘璞 on 2020/12/15.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface LPWechatLoginViewController : UIViewController<WXApiDelegate>
@property (assign, nonatomic) BOOL send;

@end

NS_ASSUME_NONNULL_END

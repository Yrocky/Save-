//
//  HLLTouchIDHelper.m
//  Save+
//
//  Created by Youngrocky on 16/6/29.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLTouchIDHelper.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>


@implementation HLLTouchIDHelper

+ (void) canEvaluatePolicy:(EvaluateResult)result{

    LAContext *context = [[LAContext alloc] init];
    
    NSError *error;
    
    // 检查是否支持Touch ID
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result) {
                result(NO,error);
            }
        });
        return;
    }
}
+ (void) evaluateWithTouchID:(EvaluateResult)reply{

    LAContext *context = [[LAContext alloc] init];
    context.maxBiometryFailures = @4;
    
    NSError *error;
    
    // 检查是否支持Touch ID
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (reply) {
                reply(NO,error);
            }
        });
        return;
    }
    
    // 进行Touch ID校验
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"验证指纹查看账单详情"
                      reply:
     ^(BOOL success, NSError *authenticationError) {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (reply) {
                 reply(success,authenticationError);
             }
         });
     }];
}
@end

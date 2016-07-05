//
//  HLLTouchIDHelper.h
//  Save+
//
//  Created by Youngrocky on 16/6/29.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EvaluateResult)(BOOL success, NSError * error);

@interface HLLTouchIDHelper : NSObject

// 检验是否支持Touch ID
+ (void) canEvaluatePolicy:(EvaluateResult)result;

// 检验是否通过Touch ID的验证
+ (void) evaluateWithTouchID:(EvaluateResult)reply;
@end

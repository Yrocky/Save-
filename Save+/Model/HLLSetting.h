//
//  HLLSetting.h
//  Save+
//
//  Created by Youngrocky on 16/6/29.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Realm/Realm.h>

@interface HLLSetting : RLMObject

/**
 *  每月预算
 */
@property NSString *              budget;

/**
 *  是否记账的时候添加结账备注
 */
@property BOOL                    remarks;

/**
 *  是否开启当前记账的位置信息
 */
@property BOOL                    location;

/**
 *  是否开启加密验证
 */
@property BOOL                    verify;

/**
 *  四位数字的密码
 */
@property BOOL                    verifyForPassword;

/**
 *  Touch ID
 */
@property BOOL                    verifyForTouchID;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<HLLSetting>
RLM_ARRAY_TYPE(HLLSetting)

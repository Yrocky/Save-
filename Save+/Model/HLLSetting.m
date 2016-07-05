//
//  HLLSetting.m
//  Save+
//
//  Created by Youngrocky on 16/6/29.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLSetting.h"

@implementation HLLSetting

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"remarks":@YES,
             @"location":@YES,
             @"verify":@NO,
             @"verifyForPassword":@NO,
             @"verifyForTouchID":@NO};
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end

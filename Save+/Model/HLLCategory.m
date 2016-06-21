//
//  HLLCategory.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategory.h"

@implementation HLLCategory

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"type":@0,
             @"active":@YES};
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end

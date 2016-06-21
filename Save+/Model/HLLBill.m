//
//  HLLBill.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLBill.h"

@implementation HLLBill

@synthesize dateString;
@synthesize dateDetailString;

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"longitude":@0.0,
             @"latitude":@0.0};
}

// 设置主键
//+ (NSString *)primaryKey {
//    
//    return @"";
//}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"dateString",
             @"dateDetailString",
             @"ID"];
}

/**
 *  这里如果属性是一个对象，不需要再这里进行约束,比如category，就不需要写
 */
+ (NSArray<NSString *> *)requiredProperties{

    return @[@"amount",
             @"date"];
}

#pragma mark - Getter

- (NSString *)dateString{

    return [self dateFromatterStringWithDate:self.date];
}

- (NSString *)dateDetailString{

    return [self dateDetailFromatterStringWithDate:self.date];
}

#pragma mark - Method

- (NSString *) dateFromatterStringWithDate:(NSDate *)date{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY MM dd"];
    
    return [formatter stringFromDate:date];
}


- (NSString *) dateDetailFromatterStringWithDate:(NSDate *)date{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY MM dd HH:mm"];
    
    return [formatter stringFromDate:date];
}
@end

//
//  HLLBillManager.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLBillManager.h"

@implementation HLLBillManager

#pragma mark - API
/**
 *  查询某一天的记账信息，日期，总账数目
 */
- (id) queryBillDataAtDate:(NSDate *)date{

    NSString * dateString = [self dateFromatterStringWithDate:date format:@"YYYY-MM-dd"];
    
    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"dateString = %@ ",[self dateFromatterStringWithDate:date format:@"YYYY MM dd"]];
    RLMResults<HLLBill *> * billes = [HLLBill objectsWithPredicate:pred];
    
    NSInteger amountCount = 0;
    for (HLLBill * bill in billes) {
        
        NSLog(@"bill:%@",bill);
        amountCount += bill.amount.integerValue;
    }
    
//    NSString * countString = [NSString stringWithFormat:@"",(unsigned long)billes.count];
    NSString * amountCountString = [NSString stringWithFormat:@"共花费%ld元",(long)amountCount];
    
    return @{@"date":dateString,
             @"count":[NSNumber numberWithInteger:billes.count],
             @"amount":amountCountString};
}

/**
 *  查询某一天的所有的记账数据
 */
- (NSArray<HLLBill *> *) queryBillsAtDate:(NSDate *)date{

    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"dateString = %@ ",[self dateFromatterStringWithDate:date format:@"YYYY MM dd"]];
    RLMResults<HLLBill *> * billes = [HLLBill objectsWithPredicate:pred];
    
    NSMutableArray * tempBills = [NSMutableArray array];
    
    for (HLLBill * bill in billes) {
        
        NSLog(@"bill:%@",bill);
        [tempBills addObject:bill];
    }
    
    return tempBills;
}

/**
 *  添加一个记账信息
 */
- (void) addBill:(HLLBill *)bill{

    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    [defaultRealm beginWriteTransaction];
    
    [defaultRealm addObject:bill];
    
    [defaultRealm commitWriteTransaction];
}

/**
 *  更新一个已有的记账信息
 */
- (void) updateBill:(HLLBill *)bill{

    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    [defaultRealm beginWriteTransaction];
    
    [HLLBill createOrUpdateInRealm:defaultRealm withValue:bill];

    [defaultRealm commitWriteTransaction];
}

/**
 *  删除一个记账信息
 */
- (void) deleteBill:(HLLBill *)bill{

    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    // 在事务中删除一个对象
    [defaultRealm beginWriteTransaction];
    
    [defaultRealm deleteObject:bill];
    
    [defaultRealm commitWriteTransaction];
}

/**
 *  查询某一天的记账个数
 */
- (NSInteger) numberOfEventsForDate:(NSDate *)date{
    
    NSArray * tempBills = [self queryBillsAtDate:date];

    NSInteger number = tempBills.count;
    
    tempBills = nil;
    
    return number;
}

/**
 *  查询某一天的记账分类的颜色
 */
- (NSArray<UIColor *> *) eventColorsForDate:(NSDate *)date{
    
    NSArray * tempBills = [self queryBillsAtDate:date];

    NSMutableArray * tempColors = [NSMutableArray array];
    
    for (HLLBill * bill in tempBills) {
        
        UIColor * color = [UIColor colorWithHexString:bill.category.categoryColor];
        
        [tempColors addObject:color];
    }
    tempBills = nil;
    return tempColors;
}

#pragma mark - Private Method

- (NSString *) dateFromatterStringWithDate:(NSDate *)date format:(NSString *)format{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}
@end

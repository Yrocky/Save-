//
//  HLLBillManager.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLBillManager.h"
#import <objc/runtime.h>


@implementation HLLBillManager

+ (instancetype)sharedManager {
    
    static HLLBillManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}
#pragma mark - API

/**
 *  所有的记账数据
 */
- (NSArray<HLLBill *> *) allBills{

    RLMResults<HLLBill *> * billes = [HLLBill allObjects];

    NSMutableArray * tempBills = [NSMutableArray array];
    
    for (HLLBill * bill in billes) {
    
        [tempBills addObject:bill];
    }
    return tempBills;
}

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
    
    NSString * amountCountString = [NSString stringWithFormat:@"共花费%ld元",(long)amountCount];
    
    return @{@"date":dateString,
             @"count":[NSNumber numberWithInteger:billes.count],
             @"amount":amountCountString};
}

/**
 *  查询某一天的所有的记账数据，用于表格的使用
 */
- (NSArray<NSDictionary *> *) queryChatDataAtDate:(NSDate *)date{

    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"dateString = %@ ",[self dateFromatterStringWithDate:date format:@"YYYY MM dd"]];
    RLMResults<HLLBill *> * billes = [HLLBill objectsWithPredicate:pred];
    
    NSMutableArray * tempBills = [NSMutableArray array];
    
    for (HLLBill * bill in billes) {
        
        NSDictionary * billDic = @{@"value":bill.amount,
                                   @"color":[UIColor colorWithHexString:bill.category.categoryColor],
                                   @"description":bill.category.categoryName};
        NSLog(@"bill:%@",billDic);
        [tempBills addObject:billDic];
    }
    
    return tempBills;
}
/**
 *  查询某一天的所有的记账数据，用于tableView的使用
 */
- (NSArray<HLLBill *> *) queryBillsAtDate:(NSDate *)date{
    
    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"dateString = %@ ",[self dateFromatterStringWithDate:date format:@"YYYY MM dd"]];
    RLMResults<HLLBill *> * billes = [HLLBill objectsWithPredicate:pred];
    
    NSMutableArray * tempBills = [NSMutableArray array];
    
    for (HLLBill * bill in billes) {
        
        [tempBills addObject:bill];
    }
    
    return tempBills;
}
/**
 *  查询某一天的所有的记账数据，根据同分类进行归类
 */
- (NSArray<NSDictionary *> *) queryBillsDataAtDate:(NSDate *)date{

    NSArray * bills = [self queryChatDataAtDate:date];
    
    //  @{@"value":bill.amount,
    //    @"color":[UIColor
    //    @"description":bill.category.categoryName};
    NSArray * archive = [self archiveObjectFromOriginalArray:bills
                                                 withBaseKey:@"description"
                                                  archiveKey:@"value"];
    
    
    return archive;
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
- (void) updateBill:(HLLBill *)bill action:(void (^)())action{

    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    [defaultRealm beginWriteTransaction];
    
    if (action) {
        action();
    }
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

/** 根据传入的`key`进行归档具有相同属性的数据 */
- (NSArray *) archiveObjectFromOriginalArray:(NSArray *)originalArray withBaseKey:(NSString *)baseKey archiveKey:(NSString *)archiveKey{
    
    NSMutableDictionary * result = [NSMutableDictionary dictionary];
    
    for (NSDictionary * billData in originalArray) {
    
        NSString * category = billData[baseKey];
        
        if ([result.allKeys containsObject:category]) {
            
            NSMutableDictionary * tempBillData = result[category];
            
            NSInteger value = [tempBillData[archiveKey] integerValue] + [billData[archiveKey] integerValue];
            [tempBillData setValue:@(value) forKey:archiveKey];
            
        }else{
        
            NSMutableDictionary * tempBillData = [NSMutableDictionary dictionaryWithDictionary:billData];
            [result setValue:tempBillData forKey:category];
        }
    }
    
    return [result allValues];
}

/** 判断某个`类`是否具有某一个`属性` */
- (BOOL) someClass:(id)class hasProperty:(NSString *)propertyName{
    
    bool has = NO;
    unsigned int outCount;
    objc_property_t * propertys = class_copyPropertyList(class, &outCount);
    
    for (int index = 0; index < outCount; index ++) {
        objc_property_t property = propertys[index];
        
        NSString * propertyKey = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName isEqualToString:propertyKey]) {
            
            has = YES;
            
            free(propertys);
            
            return has;
        }
    }
    free(propertys);
    
    return has;
}


@end

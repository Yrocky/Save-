//
//  HLLBillManager.h
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLLBill.h"

@interface HLLBillManager : NSObject

/**
 *  所有的记账数据
 */
- (NSArray<HLLBill *> *) allBills;

/**
 *  查询某一天的记账信息，日期，总账数目
 */
- (id) queryBillDataAtDate:(NSDate *)date;

/**
 *  查询某一天的所有的记账数据
 */
- (NSArray<HLLBill *> *) queryBillsAtDate:(NSDate *)date;

/**
 *  查询某一天的所有的记账数据，根据同分类进行归类
 */
- (NSArray<NSDictionary *> *) queryBillsDataAtDate:(NSDate *)date;

/**
 *  添加一个记账信息
 */
- (void) addBill:(HLLBill *)bill;

/**
 *  更新一个已有的记账信息
 */
- (void) updateBill:(HLLBill *)bill;

/**
 *  删除一个记账信息
 */
- (void) deleteBill:(HLLBill *)bill;

/**
 *  查询某一天的记账个数
 */
- (NSInteger) numberOfEventsForDate:(NSDate *)date;

/**
 *  查询某一天的记账分类的颜色
 */
- (NSArray<UIColor *> *) eventColorsForDate:(NSDate *)date;
@end

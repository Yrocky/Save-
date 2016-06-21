//
//  HLLBill.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Realm/Realm.h>
#import "HLLCategory.h"

@interface HLLBill : RLMObject
/**
 *  id
 */
@property NSNumber<RLMInt>      * ID;

/**
 * 当前记账的类别
 */
@property HLLCategory           * category;

/**
 *  当前记账的金额
 */
@property NSNumber<RLMDouble>   * amount;

/**
 *  记账的备注信息
 */
@property NSString      * note;

/**
 *  记账的日期
 */
@property NSDate        * date;

/**
 *  记账日期的格式化字符串 YYYY MM dd，仅用于getter，不做setter
 */
@property NSString      * dateString;


/**
 *  记账日期的详细格式化字符串 YYYY MM dd hh:mm，仅用于getter，不做setter
 */
@property NSString      * dateDetailString;

/**
 *  记账的经度
 */
@property double longitude;

/**
 *  记账的纬度
 */
@property double latitude;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<HLLBill>
RLM_ARRAY_TYPE(HLLBill)

/*
 存储可空数字目前已经可以通过 NSNumber 属性完成。
 
 由于 Realm 对不同类型的数字采取了不同的存储格式，因此设置可空的数字属性必须是 RLMInt、RLMFloat、RLMDouble 或者 RLMBool 其中一个类型。
 
 如果不设置，可以直接使用属性的原始类型，比如
 
 @property int category;
 
 @property double amount;
 */
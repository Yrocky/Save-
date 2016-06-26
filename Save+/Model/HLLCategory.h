//
//  HLLCategory.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Realm/Realm.h>

@interface HLLCategory : RLMObject


/**
 *  当前记账的收入/支出类型，支出 = 0，收入 = 1
 */
@property NSNumber<RLMInt>      * type;

/**
 *  分类的排列
 */
@property NSInteger               categoryRank;

/**
 *  分类的名称
 */
@property NSString              * categoryName;

/**
 *  分类的颜色
 */
@property NSString              * categoryColor;

/**
 *  分类的图标
 */
@property NSString              * categoryIcon;

/**
 *  当前分类是否显示
 */
@property BOOL                    active;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<HLLCategory>
RLM_ARRAY_TYPE(HLLCategory)

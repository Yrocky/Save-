//
//  HLLCategoryHelper.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryHelper.h"
#import "HLLSetting.h"

@implementation HLLCategoryHelper

+ (instancetype) shareCategoryHelper{
 
    static HLLCategoryHelper *shared_helper = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_helper = [[self alloc] init];
    });
    return shared_helper;
}


#pragma mark -
#pragma mark Private

- (void) addCategoryWithCategoryData:(NSDictionary *)categoryData{
    
    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    [defaultRealm beginWriteTransaction];
    
    HLLCategory * category = [[HLLCategory alloc] init];
    category.active = [categoryData[@"selected"] boolValue];
    category.categoryIcon = categoryData[@"icon"];
    category.categoryName = categoryData[@"name"];
    category.categoryColor = categoryData[@"color"];
    
    [defaultRealm addObject:category];
    
    [defaultRealm commitWriteTransaction];
}

- (void) addCategoryWithCategoryDatas:(NSArray *)catgoryDatas{
    
    for (NSDictionary * categoryData in catgoryDatas) {
        
        [self addCategoryWithCategoryData:categoryData];
    }
}

#pragma mark -
#pragma mark API

- (NSArray <HLLCategory *>*) allCategory{

    RLMResults<HLLCategory *> * categories = [HLLCategory allObjects];
    
    NSMutableArray * tempCategories = [NSMutableArray array];
    
    for (HLLCategory * category in categories) {
        
        [tempCategories addObject:category];
    }
    return tempCategories;
}

- (void) updateCategory:(HLLCategory *)category action:(void (^)())action{
    
    RLMRealm * defaultRealm = [RLMRealm defaultRealm];
    
    [defaultRealm beginWriteTransaction];
    
    if (action) {
        action();
    }
    
    [HLLCategory createOrUpdateInRealm:defaultRealm withValue:category];
    
    [defaultRealm commitWriteTransaction];
}

- (HLLCategory *) queryCategoryWithIcon:(NSString *)icon{
    
    // 使用 NSPredicate 查询
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"categoryIcon = %@ ",icon];
    RLMResults<HLLCategory *> * billes = [HLLCategory objectsWithPredicate:pred];
    
    if (billes.count > 0) {
        return [billes firstObject];
    }
    return nil;
}


#pragma mark -
#pragma mark Default

- (void) loadDefault{
    
    [self loadDefaultSetting];
    
    [self addCategoryWithCategoryDatas:[self loadDefaultCategory]];
}

- (void) loadDefaultSetting{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        RLMRealm * defaultRealm = [RLMRealm defaultRealm];
        
        [defaultRealm beginWriteTransaction];
        
        HLLSetting * setting = [[HLLSetting alloc] init];
        setting.budget = nil;
        [defaultRealm addObject:setting];

        [defaultRealm commitWriteTransaction];
        
    });
}

- (NSArray *) loadDefaultCategory{
    
    return @[@{@"name":@"吃饭",
               @"icon":@"category_icon_food",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"房租",
               @"icon":@"category_icon_home",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"话费",
               @"icon":@"category_icon_phone",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"交通费",
               @"icon":@"category_icon_transport",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"超市",
               @"icon":@"category_icon_groceries",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"购物",
               @"icon":@"category_icon_clothing",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"网上借贷",
               @"icon":@"category_icon_savings",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"医药",
               @"icon":@"category_icon_healthcare",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"图书",
               @"icon":@"category_icon_education",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"游玩",
               @"icon":@"category_icon_trekking",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"电影",
               @"icon":@"category_icon_cinema",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"恋爱",
               @"icon":@"category_icon_love",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"借钱",
               @"icon":@"category_icon_bills",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"礼物",
               @"icon":@"category_icon_gifts",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"浪",
               @"icon":@"category_icon_drink",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"爱好",
               @"icon":@"category_icon_hobbies",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"存钱",
               @"icon":@"category_icon_income_extra",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"幼儿",
               @"icon":@"category_icon_kids",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"飞机",
               @"icon":@"category_icon_travel",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"汽车",
               @"icon":@"category_icon_car",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"商务",
               @"icon":@"category_icon_business",
               @"color":[NSNull null],
               @"selected":@(0)},
             @{@"name":@"其他",
               @"icon":@"category_icon_income_other",
               @"color":[NSNull null],
               @"selected":@(0)},
             ];

}
@end


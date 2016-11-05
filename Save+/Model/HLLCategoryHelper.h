//
//  HLLCategoryHelper.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLLCategory.h"


@interface HLLCategoryHelper : NSObject

+ (instancetype) shareCategoryHelper;

- (NSArray <HLLCategory *>*) allCategory;
- (HLLCategory *) queryCategoryWithIcon:(NSString *)icon;
- (void) updateCategory:(HLLCategory *)category action:(void (^)())action;

- (void) loadDefault;
@end

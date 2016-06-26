//
//  HLLCategoryView.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"
#import "HLLAnimationProtocol.h"

@class HLLCategoryView;
@protocol HLLCategoryViewDelegate <NSObject>

@optional;
// 挑选某一个分类
- (void) categoryView:(HLLCategoryView *)categoryView didSelectedCategoryItem:(id)item;
// 点击最后一个设置按钮
- (void) categoryViewDidSetupCategories;

@end
@interface HLLCategoryView : UIView<HLLNibProtocol,HLLAnimationProtocol>

@property (nonatomic ,weak) id<HLLCategoryViewDelegate> delegate;

- (void) reloadCategoryView;

- (void) clearCategory;
@end

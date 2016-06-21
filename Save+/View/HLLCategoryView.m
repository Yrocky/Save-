//
//  HLLCategoryView.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryView.h"

@implementation HLLCategoryView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLCategoryView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLInputView";
}

#pragma mark - API


@end

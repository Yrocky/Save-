//
//  HLLInputView.m
//  Save+
//
//  Created by Youngrocky on 16/6/17.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLInputView.h"

@implementation HLLInputView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLInputView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLInputView";
}

#pragma mark - API

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

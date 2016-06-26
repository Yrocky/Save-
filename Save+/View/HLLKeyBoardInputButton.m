//
//  HLLKeyBoardInputButton.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLKeyBoardInputButton.h"

@implementation HLLKeyBoardInputButton


- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self hll_setBackgroundImageWithColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"F2F2F2"] forState:UIControlStateHighlighted];
        
        [self setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateHighlighted];
    }
    return self;
}
@end

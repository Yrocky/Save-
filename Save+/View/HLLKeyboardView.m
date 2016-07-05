//
//  HLLKeyboardView.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLKeyboardView.h"

@interface HLLKeyboardView ()

@property (nonatomic ,assign) CGRect originalFrame;

@end
@implementation HLLKeyboardView

- (void)awakeFromNib{

    [super awakeFromNib];

}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{

    return [[[NSBundle mainBundle] loadNibNamed:[HLLKeyboardView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{

    return @"HLLKeyboardView";
}

#pragma mark - HLLAnimationProtocol

- (void)showAnimaiton{
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0f;
//        self.frame = self.originalFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenAnimation{
    
    CGRect frame = self.frame;
    self.originalFrame = self.frame;
    frame.origin.y = self.bottom;
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
//        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - API


@end

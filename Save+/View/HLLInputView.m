//
//  HLLInputView.m
//  Save+
//
//  Created by Youngrocky on 16/6/17.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLInputView.h"

@interface HLLInputView ()

@property (nonatomic ,strong) IBOutlet UIImageView * categoryIconImageView;

@property (nonatomic ,strong) IBOutlet UILabel * inputAmountLabel;

@property (nonatomic ,strong) IBOutlet UILabel * signLabel;

@property (nonatomic ,strong) NSMutableString * amount;

@property (nonatomic ,assign ,readwrite) NSInteger amountNumber;
@property (nonatomic ,assign ,readwrite) BOOL nextCommit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * inputViewlHeightConstraint;
@end
@implementation HLLInputView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    _amount = [NSMutableString string];
    
    self.categoryIconImageView.hidden = YES;
    self.categoryIconImageView.image = nil;
    
    if (isLessThenIPhone6) {
        
        _inputViewlHeightConstraint.constant = 60.0f;
    }else{
    
        _inputViewlHeightConstraint.constant = 80.0f;
    }
}

- (BOOL)nextCommit{

    return (self.categoryIconImageView.image != nil) && self.amountNumber;
}
#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLInputView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLInputView";
}

#pragma mark - API

- (void) updateCategoryIconWithImageName:(NSString *)imageName withColor:(UIColor *)color{

    self.categoryIconImageView.hidden = NO;
    
    self.categoryIconImageView.image = [UIImage imageNamed:imageName];
    
    [UIView animateWithDuration:.55 animations:^{
        
        self.backgroundColor = color;
    }];
}

- (void) updateAmountWithNumber:(NSInteger)number{

    if (self.inputAmountLabel.text.length > 7) {
        return;
    }
    [self.amount appendString:[NSString stringWithFormat:@"%ld",(long)number]];
    
    if ([self.amount hasPrefix:@"0"] && self.amount.length > 1 ) {
        
        [self.amount deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    self.inputAmountLabel.text = self.amount;
    
    self.amountNumber = self.amount.integerValue;
}

- (void) delelteNumber{

    if (self.amount.length > 0) {
        
        [self.amount deleteCharactersInRange:NSMakeRange(self.amount.length - 1, 1)];
        
        if (self.amount.length == 0) {
        
            self.inputAmountLabel.text = @"0";
            
            self.amountNumber = 0;
        }else{
        
            self.inputAmountLabel.text = self.amount;
            
            self.amountNumber = self.amount.integerValue;
        }
    }else{
    
        self.inputAmountLabel.text = @"0";
        
        self.amountNumber = 0;
    }
}

- (void) clearInput{

    self.inputAmountLabel.text = @"0";
    self.amountNumber = 0;
    [self.amount deleteCharactersInRange:NSMakeRange(0, self.amount.length)];
    
    self.categoryIconImageView.image = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

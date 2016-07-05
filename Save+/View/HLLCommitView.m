//
//  HLLCommitView.m
//  Save+
//
//  Created by Youngrocky on 16/6/26.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCommitView.h"

@interface HLLCommitView ()

@property (nonatomic ,strong) IBOutlet UIButton * commitButton;

@property (nonatomic ,strong) IBOutlet UIButton * cancelButton;

@end
@implementation HLLCommitView

- (void)awakeFromNib{

    [super awakeFromNib];
    
    self.commitButton.layer.cornerRadius = self.commitButton.width / 2;
    self.commitButton.layer.masksToBounds = YES;
    [self.commitButton hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"21AF73"] forState:UIControlStateNormal];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.cancelButton.layer.cornerRadius = self.cancelButton.width / 2;
    self.cancelButton.layer.masksToBounds = YES;
    [self.cancelButton hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.commitButton.layer.cornerRadius = self.commitButton.width / 2;
    self.cancelButton.layer.cornerRadius = self.cancelButton.width / 2;

}
#pragma mark - Action

- (IBAction)commitButtonDidHandle:(id)sender{

    if (self.delegate && [self.delegate respondsToSelector:@selector(commitViewDidSelectedCommitButton:)]) {
        [self.delegate commitViewDidSelectedCommitButton:self];
    }
}

- (IBAction)cancelButtonDidHandle:(id)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(commitViewDidSelectedCancelButton:)]) {
        [self.delegate commitViewDidSelectedCancelButton:self];
    }
}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLCommitView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLCommitView";
}

#pragma mark - HLLAnimationProtocol

- (void)showAnimaiton{
    
    self.commitButton.layer.transform = CATransform3DScale(self.commitButton.layer.transform, 0.1, 0.1, 0.1);
    self.cancelButton.layer.transform = CATransform3DScale(self.cancelButton.layer.transform, 0.1, 0.1, 0.1);
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.commitButton.layer.transform = CATransform3DIdentity;
        self.cancelButton.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenAnimation{
    
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.commitButton.layer.transform = CATransform3DScale(self.commitButton.layer.transform, 0.1, 0.1, 0.1);
        self.cancelButton.layer.transform = CATransform3DScale(self.cancelButton.layer.transform, 0.1, 0.1, 0.1);
        
    } completion:^(BOOL finished) {
        
        self.commitButton.layer.transform = CATransform3DIdentity;
        self.cancelButton.layer.transform = CATransform3DIdentity;
    }];
}

@end

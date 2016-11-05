//
//  HLLDeleteBillView.m
//  Save+
//
//  Created by Rocky Young on 16/11/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLDeleteBillView.h"
#import "UIImage+ImageEffects.h"


@interface HLLDeleteBillView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (nonatomic ,copy) ButtonAction cancelAction;
@property (nonatomic ,copy) ButtonAction sureAction;
@end

@implementation HLLDeleteBillView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 5.0f;
    [self.cancelButton hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"F26163"] forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.cornerRadius = 5.0f;
    [self.sureButton hll_setBackgroundImageWithColor:kTheme_Color forState:UIControlStateNormal];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    
    self.alpha = 0.0f;
    UIImage * backgroundImage = [UIImage imageWithColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
    backgroundImage = [backgroundImage blurImageWithRadius:20];
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}


#pragma mark -
#pragma mark API

- (void) configureDeleteBillWithTitle:(NSString *)title cancelAction:(ButtonAction)cancelAction sureAction:(ButtonAction)sureAction{

    self.titleLabel.text = title;
    self.cancelAction = cancelAction;
    self.sureAction = sureAction;
}

- (void) showDeleteBillViewForView:(UIView *)view{

    if (view) {
        [view addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    [self showAnimation];
}

#pragma mark -
#pragma mark HLLNibProtocol

+ (instancetype) hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

+ (NSString *) hll_nibName{
    
    return NSStringFromClass([self class]);
}

#pragma mark -
#pragma mark Action

- (IBAction)cancelAction:(UIButton *)sender {
    
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self hideAniamtion];
}

- (IBAction)sureAction:(UIButton *)sender {
    
    if (self.sureAction) {
        self.sureAction();
    }
    [self hideAniamtion];
}


#pragma mark -
#pragma mark Animation

- (void) showAnimation{
    
    [UIView animateWithDuration:CommonAnimationDeration animations:^{
        
        self.alpha = 1.0f;
    }];
}

- (void) hideAniamtion{
    
    [UIView animateWithDuration:CommonAnimationDeration animations:^{
        
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        self.contentView = nil;
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

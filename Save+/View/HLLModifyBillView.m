//
//  HLLModifyBillView.m
//  Save+
//
//  Created by Rocky Young on 16/11/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLModifyBillView.h"
#import "HLLBill.h"
#import "UIImage+ImageEffects.h"


@interface HLLModifyBillView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *categoryContentView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *billDescriptLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *billDescribeTextField;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conetntViewTopConstraint;


@property (nonatomic ,strong) NSString * amount;
@property (nonatomic ,strong) NSString * describe;
@property (nonatomic ,copy) CommitAction commit;

@end
@implementation HLLModifyBillView


- (void)awakeFromNib{

    [super awakeFromNib];
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.categoryContentView.layer.masksToBounds = YES;
    self.categoryContentView.layer.cornerRadius = 25.0f;
    
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 5.0f;
    [self.cancelButton hll_setBackgroundImageWithColor:[UIColor colorWithHexString:@"F26163"] forState:UIControlStateNormal];
    
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.cornerRadius = 5.0f;
    [self.sureButton hll_setBackgroundImageWithColor:kTheme_Color forState:UIControlStateNormal];
    
    self.alpha = 0.0f;
    UIImage * backgroundImage = [UIImage imageWithColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
    backgroundImage = [backgroundImage blurImageWithRadius:20];
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}


#pragma mark -
#pragma mark API

- (void) showModifyBillViewForView:(UIView *)view{

    if (view) {
        
        [view addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    [self showAnimation];
}

- (void) configureModifyViewWithBill:(HLLBill *)bill{

    self.categoryContentView.backgroundColor = [UIColor colorWithHexString:bill.category.categoryColor];
    self.categoryIconImageView.image = [[UIImage imageNamed:bill.category.categoryIcon] tintedGradientImageWithColor:[UIColor whiteColor]];
    self.categoryNameLabel.text = bill.category.categoryName;
    self.billAmountTextField.text = [NSString stringWithFormat:@"%@",bill.amount];
    self.billDescribeTextField.text = [NSString stringWithFormat:@"%@",bill.note];
    
    self.amount = [NSString stringWithFormat:@"%@",bill.amount];
    self.describe = [NSString stringWithFormat:@"%@",bill.note];
}

- (void)commitModifyBillInfo:(void (^)(NSString *, NSString *))commit{

    self.commit = commit;
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
- (IBAction)modifyAmountAction:(UITextField *)sender {
    
    self.amount = sender.text;
}

- (IBAction)modifyDescribeAction:(UITextField *)sender {
    
    self.describe = sender.text;
}

- (IBAction)cancelAction:(id)sender {
    
    [self hideAnimation];
}

- (IBAction)sureAction:(id)sender {
    
    if (self.commit) {
        self.commit(self.amount,self.describe);
    }
    
    [self hideAnimation];
}
- (IBAction)tapGestureHandle:(id)sender {
    
    [self endEditing:YES];
//    [self hideAnimation];
}

#
#pragma mark -
#pragma mark Animation

- (void) showAnimation{
    
    [UIView animateWithDuration:CommonAnimationDeration animations:^{
        
        self.alpha = 1.0f;
    }];
}

- (void) hideAnimation{
    
    [self endEditing:YES];

    [UIView animateWithDuration:CommonAnimationDeration animations:^{
        
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.contentView = nil;
        [self removeFromSuperview];
    }];
}


@end

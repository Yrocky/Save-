//
//  HLLBillTableViewCell.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLBillTableViewCell.h"
#import "HLLBill.h"

@interface HLLBillTableViewCell ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *categoryBackgroundView;

@property (weak, nonatomic) IBOutlet UIView *categoryIconBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryAmountLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryLineViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelAndDetailMarginConstraint;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *categoryPanGesture;

// 手势相关的
@property (nonatomic ,assign) CGPoint originalCenter;

@property (nonatomic ,assign) BOOL complantOnDragRelease;
@property (nonatomic ,assign) BOOL deleteOnDragRelease;

@property (weak, nonatomic) IBOutlet UIView *editContentView;
@property (nonatomic ,strong) IBOutlet UILabel * editLabel;

@property (weak, nonatomic) IBOutlet UIView *deleteContentView;
@property (nonatomic ,strong) IBOutlet UILabel * deleteLabel;
@end

@implementation HLLBillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.categoryBackgroundView.backgroundColor         = [UIColor clearColor];
    self.categoryIconBackgroundView.layer.masksToBounds = YES;
    self.categoryIconBackgroundView.backgroundColor     = [UIColor whiteColor];
    self.categoryIconBackgroundView.layer.cornerRadius  = 25;
    
    self.categoryLineViewHeightConstraint.constant = OnePixel;
    self.categoryLineView.backgroundColor          = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
    
    self.categoryPanGesture          = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(categoryPanGestureHandle:)];
    self.categoryPanGesture.delegate = self;
    [self.categoryBackgroundView addGestureRecognizer:self.categoryPanGesture];
    
    self.originalCenter        = CGPointZero;
    self.complantOnDragRelease = NO;
    self.deleteOnDragRelease   = NO;

    self.editLabel.text        = @"修改";
    self.deleteLabel.text      = @"删除";
}

- (void)layoutSubviews{

    [super layoutSubviews];
}
#pragma mark - HLLNibCellProtocol

+ (UINib *) hll_nib{
    
    return [UINib nibWithNibName:@"HLLBillTableViewCell" bundle:nil];
}

+ (NSString *) hll_cellIdentifier{
    
    return @"HLLBillTableViewCell";
}

- (void)hll_configureCellWithData:(HLLBill *)bill{
    
    self.categoryTitleLabel.text                    = [NSString stringWithFormat:@"%@",bill.category.categoryName];

    self.categoryIconBackgroundView.backgroundColor = [UIColor colorWithHexString:bill.category.categoryColor];

    self.categoryIconImageView.image                = [UIImage imageNamed:[NSString stringWithFormat:@"%@",bill.category.categoryIcon]];
    
    if (bill.note.length > 0) {
        
        self.categoryDetailLabel.text = [NSString stringWithFormat:@"%@",bill.note];
    }else if (bill.locationInfo){
        
        self.categoryDetailLabel.text = [NSString stringWithFormat:@"%@",bill.locationInfo];
    }
    
    if (self.categoryDetailLabel.height > 20) {
        
        self.titleLabelAndDetailMarginConstraint.constant = 5.0f;
    }else{
        self.titleLabelAndDetailMarginConstraint.constant = 10.0f;
    }
    
    self.categoryAmountLabel.text = [NSString stringWithFormat:@"%@元",bill.amount];
    
}

#pragma mark - Action

- (IBAction)categoryPanGestureHandle:(UIPanGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = self.categoryBackgroundView.center;
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        // 得到滑动中的点，在触摸点左边是负，右边是正
        CGPoint transtion                  = [gesture translationInView:self.categoryBackgroundView];
        self.categoryBackgroundView.center = CGPointMake(self.originalCenter.x + transtion.x, self.originalCenter.y);

        // 计算是否完成或删除
        self.deleteOnDragRelease           = self.categoryBackgroundView.frame.origin.x < - self.categoryBackgroundView.frame.size.width / 3.0;

        self.complantOnDragRelease         = self.categoryBackgroundView.frame.origin.x > self.categoryBackgroundView.frame.size.width / 3.0;

        CGFloat cueAlpha                   = fabs(self.categoryBackgroundView.frame.origin.x) / (self.categoryBackgroundView.frame.size.width / 3.0);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.editContentView.alpha   = cueAlpha;
            self.deleteContentView.alpha = cueAlpha;
            
            self.editContentView.backgroundColor   = self.complantOnDragRelease ? [UIColor colorWithHexString:@"#21AF73"]: [UIColor colorWithHexString:@"#6F818D"];
            self.deleteContentView.backgroundColor = self.deleteOnDragRelease ? [UIColor colorWithHexString:@"#F26163"] : [UIColor colorWithHexString:@"#6F818D"];
        }];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded){
        
        CGRect originalFrame = CGRectMake(0, 0, self.categoryBackgroundView.width, self.categoryBackgroundView.height);
        
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:15 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.categoryBackgroundView.frame = originalFrame;
            self.userInteractionEnabled = NO;
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
            if (self.deleteOnDragRelease) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(billTableViewCellDidDeleted:)]) {
                    [self.delegate billTableViewCellDidDeleted:self];
                }
                
            } else if (self.complantOnDragRelease) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(billTableViewCellDidEdited:)]) {
                    [self.delegate billTableViewCellDidEdited:self];
                }
            }
        }];
        
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        UIPanGestureRecognizer * panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        
        CGPoint translation = [panGestureRecognizer translationInView:self.categoryBackgroundView];

        if (fabs(translation.x) > fabs(translation.y)) {
            return YES;
        }
        return NO;
    }
    return NO;
}

@end

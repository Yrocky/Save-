//
//  HLLBillSectionHeaderView.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLBillSectionHeaderView.h"

@interface HLLBillSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountCountLabel;

@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end
@implementation HLLBillSectionHeaderView


- (void)awakeFromNib{

    [super awakeFromNib];
    
    self.topLineViewHeightConstraint.constant = OnePixel;
    self.bottomLineViewHeightConstraint.constant = OnePixel;
    
    self.topLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
    self.bottomLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
}

#pragma mark - API

- (void) configureSectionHeaderViewWithData:(id)data{
    
    self.dateLabel.text = [data objectForKey:@"date"];
    
    NSInteger count = [[data objectForKey:@"count"] integerValue];
    self.amountCountLabel.hidden = !count;
    self.topLineView.hidden = !count;
    self.amountCountLabel.text = [NSString stringWithFormat:@"记账%lu笔    %@",count,[data objectForKey:@"amount"]];
}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLBillSectionHeaderView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLBillSectionHeaderView";
}
@end

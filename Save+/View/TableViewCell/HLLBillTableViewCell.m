//
//  HLLBillTableViewCell.m
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLBillTableViewCell.h"
#import "HLLBill.h"

@interface HLLBillTableViewCell ()


@end

@implementation HLLBillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - HLLNibCellProtocol

+ (UINib *) hll_nib{
    
    return [UINib nibWithNibName:@"HLLBillTableViewCell" bundle:nil];
}

+ (NSString *) hll_cellIdentifier{
    
    return @"HLLBillTableViewCell";
}
- (void)hll_configureCellWithData:(HLLBill *)bill{
    
    self.textLabel.text = [NSString stringWithFormat:@"%@",bill.amount];
    
    self.detailTextLabel.text = bill.dateDetailString;
    
}
@end

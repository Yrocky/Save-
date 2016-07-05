//
//  HLLSettingTableViewCell.m
//  Save+
//
//  Created by Youngrocky on 16/6/29.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLSettingTableViewCell.h"

@implementation HLLSettingTableViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
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

    return [UINib nibWithNibName:@"HLLSettingTableViewCell" bundle:nil];
}

+ (NSString *) hll_cellIdentifier{

    return @"HLLSettingTableViewCell";
}
- (void)hll_configureCellWithData:(id)data{

    
}
@end

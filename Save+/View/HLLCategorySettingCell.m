//
//  HLLCategorySettingCell.m
//  Save+
//
//  Created by Rocky Young on 16/11/4.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategorySettingCell.h"
#import "HLLCategory.h"

@interface HLLCategorySettingCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UIView *categoryContentView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *categoryLineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *categoryLineView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryArrowImageView;

@end

@implementation HLLCategorySettingCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.categoryLineView.backgroundColor = kLine_Color;
    self.categoryLineView.hidden = YES;
    self.categoryLineViewHeightConstraint.constant = OnePixel;

    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.layer.borderWidth = OnePixel;
    self.contentView.layer.borderColor = self.categoryLineView.backgroundColor.CGColor;
    
    self.categoryIconImageView.backgroundColor = [UIColor clearColor];
    self.categoryContentView.backgroundColor = [UIColor clearColor];
    self.categoryContentView.layer.masksToBounds = YES;;
    self.categoryContentView.layer.cornerRadius = 25.0f;
    
    self.categoryArrowImageView.image = [[UIImage imageNamed:@"right4"] tintedGradientImageWithColor:self.categoryLineView.backgroundColor];
}


#pragma mark -
#pragma mark HLLNibCellProtocol

+ (UINib *) hll_nib{

    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (NSString *) hll_cellIdentifier{
 
    return NSStringFromClass([self class]);
}

- (void) hll_configureCellWithData:(HLLCategory *)data{
    
    BOOL selected = data.active;
    UIImage * image = [UIImage imageNamed:data.categoryIcon];
    
    self.categoryNameLabel.text = [NSString stringWithFormat:@"%@",data.categoryName];
    
    if (!selected) {
        
        self.categoryIconImageView.image = [image tintedGradientImageWithColor:kLine_Color];
        self.categoryContentView.backgroundColor = [UIColor clearColor];
        self.categoryArrowImageView.hidden = NO;
    }else{
        
        UIColor * color = [UIColor colorWithHexString:data.categoryColor];
        
        self.categoryIconImageView.image = [image tintedGradientImageWithColor:[UIColor whiteColor]];
        self.categoryContentView.backgroundColor = color;
        self.categoryArrowImageView.hidden = YES;
    }
}
@end

//
//  HLLCategoryCollectionViewCell.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryCollectionViewCell.h"
#import "HLLCategoryCellContentView.h"
#import "HLLCategory.h"

@interface HLLCategoryCollectionViewCell ()

@property (weak, nonatomic) IBOutlet HLLCategoryCellContentView *categoryContentView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;


@end
@implementation HLLCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.categoryContentView.backgroundColor = [UIColor clearColor];
    self.categoryNameLabel.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        [self.categoryContentView showCircleLayerAnimation];
    }else{
        [self.categoryContentView hidenCircleLayerAnimation];
    }
}
#pragma mark - HLLNibCellProtocol

+ (UINib *) hll_nib{

    return [UINib nibWithNibName:@"HLLCategoryCollectionViewCell" bundle:nil];
}

+ (NSString *) hll_cellIdentifier{

    return @"HLLCategoryCollectionViewCell";
}

- (void) hll_configureCellWithData:(HLLCategory *)category{

    UIImage * categoryIcon = [UIImage imageNamed:category.categoryIcon];
    UIColor * categoryColor = [UIColor colorWithHexString:category.categoryColor];
    
    self.categoryContentView.categoryIconImageView.image = [categoryIcon tintedGradientImageWithColor:categoryColor];
    
    self.categoryContentView.circleColor = categoryColor;
    
    self.categoryNameLabel.text = category.categoryName;
}

@end

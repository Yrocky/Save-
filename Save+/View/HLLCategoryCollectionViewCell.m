//
//  HLLCategoryCollectionViewCell.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryCollectionViewCell.h"

@implementation HLLCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - HLLNibCellProtocol

+ (UINib *) hll_nib{

    return [UINib nibWithNibName:@"HLLCategoryCollectionViewCell" bundle:nil];
}

+ (NSString *) hll_cellIdentifier{

    return @"HLLCategoryCollectionViewCell";
}

- (void) hll_configureCellWithData:(id)data{

    
}

@end

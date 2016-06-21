//
//  HLLNibCellProtocol.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//
//  通用于使用Xib进行布局的UITableViewCell和UICollectionViewCell
//
#import <Foundation/Foundation.h>

@protocol HLLNibCellProtocol <NSObject>

@required;

+ (UINib *) hll_nib;

+ (NSString *) hll_cellIdentifier;

@optional;

- (void) hll_configureCellWithData:(id)data;
@end

//
//  HLLBillTableViewCell.h
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibCellProtocol.h"

@class HLLBillTableViewCell;
@protocol HLLBillTableViewCellDelegate <NSObject>

// 删除
- (void) billTableViewCellDidDeleted:(HLLBillTableViewCell *)cell;

// 编辑
- (void) billTableViewCellDidEdited:(HLLBillTableViewCell *)cell;

@end

@interface HLLBillTableViewCell : UITableViewCell<HLLNibCellProtocol>

@property (nonatomic ,weak) id<HLLBillTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *categoryLineView;

@end

//
//  HLLBillSectionHeaderView.h
//  Save+
//
//  Created by Youngrocky on 16/7/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"


@interface HLLBillSectionHeaderView : UIView<HLLNibProtocol>

- (void) configureSectionHeaderViewWithData:(id)data;
@end

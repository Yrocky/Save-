//
//  HLLModifyBillView.h
//  Save+
//
//  Created by Rocky Young on 16/11/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"

typedef void(^CommitAction)(NSString *amount,NSString *describe);

@interface HLLModifyBillView : UIView<HLLNibProtocol>

- (void) showModifyBillViewForView:(UIView *)view;

- (void) configureModifyViewWithBill:(id)bill;

- (void) commitModifyBillInfo:(CommitAction)commit;

@end

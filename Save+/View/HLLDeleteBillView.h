//
//  HLLDeleteBillView.h
//  Save+
//
//  Created by Rocky Young on 16/11/5.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"

typedef void(^ButtonAction)();

@interface HLLDeleteBillView : UIView<HLLNibProtocol>

- (void) configureDeleteBillWithTitle:(NSString *)title cancelAction:(ButtonAction)cancelAction sureAction:(ButtonAction)sureAction;

- (void) showDeleteBillViewForView:(UIView *)view;
@end

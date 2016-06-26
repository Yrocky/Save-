//
//  HLLInputView.h
//  Save+
//
//  Created by Youngrocky on 16/6/17.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"

@interface HLLInputView : UIView<HLLNibProtocol>

@property (nonatomic ,assign ,readonly) BOOL nextCommit;

- (void) updateCategoryIconWithImageName:(NSString *)imageName
                               withColor:(UIColor *)color;

- (void) updateAmountWithNumber:(NSInteger)number;

- (void) delelteNumber;

- (void) clearInput;
@end

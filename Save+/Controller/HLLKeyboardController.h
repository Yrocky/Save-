//
//  HLLKeyboardController.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLLKeyboardController;

@protocol HLLKeyboardControllerDelegate <NSObject>

@required;

- (void) keyboardController:(HLLKeyboardController *)keyboard didInputNumber:(NSInteger)number;

- (void) keyboardControllerDidDeleteNumber:(HLLKeyboardController *)keyboard;

- (void) keyboardControllerDidCommitInput:(HLLKeyboardController *)keyboard;

@end
@interface HLLKeyboardController : UIViewController

@property (nonatomic ,weak) id<HLLKeyboardControllerDelegate> delegate;

@end

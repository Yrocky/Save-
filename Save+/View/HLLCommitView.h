//
//  HLLCommitView.h
//  Save+
//
//  Created by Youngrocky on 16/6/26.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"
#import "HLLAnimationProtocol.h"

@class HLLCommitView;

@protocol HLLCommitViewDelegate <NSObject>

- (void) commitViewDidSelectedCommitButton:(HLLCommitView *)commitView;

- (void) commitViewDidSelectedCancelButton:(HLLCommitView *)commitView;

@end

@interface HLLCommitView : UIView<HLLAnimationProtocol,HLLNibProtocol>

@property (nonatomic ,weak) id<HLLCommitViewDelegate> delegate;
@end

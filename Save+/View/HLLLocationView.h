//
//  HLLLocationView.h
//  Save+
//
//  Created by Youngrocky on 16/7/4.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"
#import "HLLAnimationProtocol.h"

@interface HLLLocationView : UIView<HLLNibProtocol,HLLAnimationProtocol>

@property (nonatomic ,strong ,readonly) NSString * loctionInfo;

@property (nonatomic ,assign ,readonly) CGFloat longitude;

@property (nonatomic ,assign ,readonly) CGFloat latitude;

// 获取用户的当前位置信息
- (void) loadCurrentLocationInfo;

@end

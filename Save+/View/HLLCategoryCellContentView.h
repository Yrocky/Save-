//
//  HLLCategoryCellContentView.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface HLLCategoryCellContentView : UIView

@property (nonatomic ,strong) CAShapeLayer * circleLayer;

@property (nonatomic ,strong) IBInspectable UIColor * circleColor;

@property (nonatomic ,strong) IBOutlet UIImageView * categoryIconImageView;

- (void) showCircleLayerAnimation;

- (void) hidenCircleLayerAnimation;
@end

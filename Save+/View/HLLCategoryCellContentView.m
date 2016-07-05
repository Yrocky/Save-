//
//  HLLCategoryCellContentView.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLCategoryCellContentView.h"

static CGFloat animationDuration = .55f;

@interface HLLCategoryCellContentView ()

@end

@implementation HLLCategoryCellContentView


- (void)awakeFromNib{
 
    [super awakeFromNib];
    
    _circleColor = [UIColor lightGrayColor];
    
    _circleLayer = [CAShapeLayer layer];
    _circleLayer.opacity = 0.0f;
    _circleLayer.borderColor = _circleColor.CGColor;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.lineWidth = 2/[UIScreen mainScreen].scale;
    [self.layer insertSublayer:_circleLayer atIndex:0];
    
}

- (void)setCircleColor:(UIColor *)circleColor{

    _circleColor = circleColor;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    CGRect rect = self.bounds;
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    _circleLayer.frame = rect;
    _circleLayer.lineWidth = 2/[UIScreen mainScreen].scale;
    
    CGFloat ovalR = ( width < height ? width / 2  : height / 2 ) - _circleLayer.lineWidth;
    CGPoint ovalCenter = CGPointMake(width/2, height/2);
    
    //
    UIBezierPath * ovalPath = [UIBezierPath bezierPathWithArcCenter:ovalCenter
                                                             radius:ovalR
                                                         startAngle:0
                                                           endAngle:2 *  3.14
                                                          clockwise:YES];
    _circleLayer.strokeColor = self.circleColor.CGColor;
    _circleLayer.fillColor = self.circleColor.CGColor;
    _circleLayer.path = ovalPath.CGPath;
    
}

#pragma mark - API

- (void) showCircleLayerAnimation{

    if (self.circleLayer.opacity == 1.0f) {
        return;
    }
    
    UIImage * categoryImage = self.categoryIconImageView.image;
    
    [CATransaction setAnimationDuration:animationDuration];
    
    [CATransaction begin];
    
    self.circleLayer.opacity = 1.0f;
    
    self.circleLayer.transform = CATransform3DIdentity;
    
    self.categoryIconImageView.image = [categoryImage tintedGradientImageWithColor:[UIColor whiteColor]];
    
    [CATransaction commit];
}

- (void) hidenCircleLayerAnimation{

    UIImage * categoryImage = self.categoryIconImageView.image;

    [CATransaction setAnimationDuration:animationDuration];
    
    [CATransaction begin];
    
    self.circleLayer.opacity = .0f;
    
    self.circleLayer.transform = CATransform3DIdentity;
    CGFloat scale = 0.5f;
    self.circleLayer.transform = CATransform3DScale(self.circleLayer.transform, scale, scale, scale);
//    😂😂😂😂😂
    
    self.categoryIconImageView.image = [categoryImage tintedGradientImageWithColor:self.circleColor];
    [CATransaction commit];

}

#pragma mark - Method

@end

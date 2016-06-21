//
//  UIImage+Tint.m
//  CategoryDemo
//
//  Created by Youngrocky on 16/5/11.
//  Copyright © 2016年 Young Rocky. All rights reserved.
//
//  kCGBlendModeOverlay:
//
//  其结果是覆盖现有的图像样本，同时保留背景的高光和阴影。背景颜色混合与源图像来反映背景的深浅。
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

#pragma mark - Public methods

- (UIImage*)tintedGradientImageWithColor:(UIColor*)tintColor{
    
    return [self tintedImageWithColor:tintColor blendingMode:kCGBlendModeOverlay];
}

- (UIImage*)tintedImageWithColor:(UIColor*)tintColor{
    
    return [self tintedImageWithColor:tintColor blendingMode:kCGBlendModeDestinationIn];
}

#pragma mark - Private methods

- (UIImage*)tintedImageWithColor:(UIColor*)tintColor blendingMode:(CGBlendMode)blendMode{
    
    // 传递一个0.0用来确保绘制的图像是原来的尺寸，这点很重要。
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0.0f);
    
    [tintColor setFill];
    
    CGRect bounds = CGRectMake(0,0,self.size.width,self.size.height);
    
    UIRectFill(bounds);
    
    // 至于这里为什么这么写，我也不是很清楚，可以点进去看一下文档，是一些通道的算法
    if (blendMode != kCGBlendModeDestinationIn) {
        
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
    }
    
    UIImage * tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end

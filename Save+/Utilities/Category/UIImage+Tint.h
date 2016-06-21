//
//  UIImage+Tint.h
//  CategoryDemo
//
//  Created by Youngrocky on 16/5/11.
//  Copyright © 2016年 Young Rocky. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

/**
 *  拥有一个具有渐变颜色的image实例
 *
 *  @param tintColor 需要渐变的颜色
 *
 *  @return 渐变的规则是由上至下变深，最深就是tintColor
 */
- (UIImage*)tintedGradientImageWithColor:(UIColor*)tintColor;
/**
 *  改变iamage实例的颜色
 *
 *  @param tintColor 想要的颜色
 *
 *  @return 改变过颜色的image实例
 */
- (UIImage*)tintedImageWithColor:(UIColor*)tintColor;

@end

//
//  UIImage+Common.h
//  CategoryDemo
//
//  Created by Youngrocky on 16/5/8.
//  Copyright © 2016年 Young Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)
/**
 *  根据颜色生成一个image实例
 */
+ (UIImage *)imageWithColor:(UIColor *)aColor;
/**
 *  根据颜色、frame生成一个image实例
 */
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
/**
 *  将原有image实例进行size的改变
 */
- (UIImage*)scaledToSize:(CGSize)targetSize;
/**
 *  将原有image实例进行size的改变，并且提供是否要求输出高质量的image
 */
- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
/**
 *  将原有image实例进行size的改变，
 */
- (UIImage*)scaledToMaxSize:(CGSize )size;
@end

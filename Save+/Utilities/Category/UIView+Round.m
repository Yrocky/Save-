//
//  UIView+Round.m
//  CategoryDemo
//
//  Created by Youngrocky on 16/5/18.
//  Copyright © 2016年 Young Rocky. All rights reserved.
//

#import "UIView+Round.h"

@implementation UIView (Round)

-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

- (void) addCornerWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners{
    
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    CGContextAddPath(ctx,path.CGPath);
    
    CGContextClip(ctx);
    
//    [self drawInRect:rect];
//    
//    CGContextDrawPath(ctx, kCGPathFillStroke);
//    
//    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return newImage;
    
}

@end

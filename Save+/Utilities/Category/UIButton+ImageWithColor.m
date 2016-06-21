//
//  UIButton+ImageWithColor.m
//  CategoryDemo
//
//  Created by Youngrocky on 16/6/15.
//  Copyright © 2016年 Young Rocky. All rights reserved.
//

#import "UIButton+ImageWithColor.h"
#import "UIImage+Common.h"

@implementation UIButton (ImageWithColor)

/**
 *  根据一个颜色值设置对应状态下的image
 */
- (void) hll_setImageWithColor:(UIColor *)color
                      forState:(UIControlState)state{
    
    [self setImage:[UIImage imageWithColor:color]
          forState:state];
}

/**
 *  根据一个颜色值设置对应状态下的backgroundImage
 */
- (void) hll_setBackgroundImageWithColor:(UIColor *)color
                                forState:(UIControlState)state{
    
    [self setBackgroundImage:[UIImage imageWithColor:color]
                    forState:state];
}
@end

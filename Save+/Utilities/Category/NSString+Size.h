//
//  NSString+Size.h
//  SimpleMetro
//
//  Created by Youngrocky on 16/5/28.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGFloat) heightWithFontSize:(CGFloat)fontSize forViewWidth:(CGFloat)width;

- (CGFloat) widthWithFontSize:(CGFloat)fontSize forViewHeight:(CGFloat)height;

@end

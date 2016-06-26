//
//  HLLKeyboardSplitView.m
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLKeyboardSplitView.h"

@implementation HLLKeyboardSplitView

- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    
    CGFloat width       = CGRectGetWidth(rect);
    CGFloat height      = CGRectGetHeight(rect);
    CGFloat vertical    = height / 4.0f;
    CGFloat horizontal  = width / 3.0f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画水平线
    for (NSInteger index = 0; index < 4; index ++) {
    
        hll_drawHorizontalLineWithContext(context, 0, width, index * vertical, self.lineColor);
    }
    
    // 画垂直线
    for (NSInteger index = 1; index < 3; index ++) {
        
        hll_drawVerticalLineWithContext(context, 0, height, index * horizontal, self.lineColor);
    }
    
    // 画边框
    hll_drawRectWithContext(context, rect, self.lineColor);
}

// 画水平的线
void hll_drawHorizontalLineWithContext(CGContextRef context, CGFloat min_x,CGFloat max_x,CGFloat y, UIColor * lineColor){
    
    CGPoint lines[] = {
        CGPointMake(min_x, y),
        CGPointMake(max_x, y),
    };
    CGContextAddLines(context, lines, sizeof(lines)/sizeof(lines[0]));
    
    CGContextSetLineWidth(context, 1.0 / [UIScreen mainScreen].scale);
    
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    CGContextStrokePath(context);
};

// 画垂直的线
void hll_drawVerticalLineWithContext(CGContextRef context, CGFloat min_y,CGFloat max_y,CGFloat x, UIColor * lineColor){
    
    CGPoint lines[] = {
        CGPointMake(x, min_y),
        CGPointMake(x, max_y),
    };
    CGContextAddLines(context, lines, sizeof(lines)/sizeof(lines[0]));
    
    CGContextSetLineWidth(context, 1.0 / [UIScreen mainScreen].scale);
    
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    CGContextStrokePath(context);
};

// 画矩形
void hll_drawRectWithContext(CGContextRef context, CGRect rect,UIColor * lineColor){
    
    CGContextSetLineWidth(context, 1.0 / [UIScreen mainScreen].scale);
    
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    CGContextAddRect(context, rect);
    
    CGContextStrokePath(context);
    CGContextSaveGState(context);
    
};
@end

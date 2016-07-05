//
//  UITableView+Line.m
//  DDXGMarkeProject
//
//  Created by 杨恒 on 16/5/6.
//  Copyright © 2016年 张涛. All rights reserved.
//

#import "UITableView+Line.h"
#import "objc/runtime.h"


@implementation UITableView (Line)

// test API
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    CGColorRef lineColor = self.cellLineColor.CGColor;
    
    //判断整个tableview 最后的元素
    if ((self.numberOfSections==(indexPath.section+1))&&indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //上短,下长
        //        [self layer:layer addLineUp:TRUE andLong:YES andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
        [self layer:layer
          addLineUp:NO
            andLong:YES
           andColor:lineColor
          andBounds:bounds
      withLeftSpace:0
      andRightSpace:0];
    }else
    {
        [self layer:layer
          addLineUp:NO
            andLong:NO
           andColor:lineColor
          andBounds:bounds
      withLeftSpace:leftSpace
      andRightSpace:0];
    }
    
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
    
}

#pragma mark - API
/**
 *  为cell添加下划线，左边有边距
 *
 *  @param cell      cell
 *  @param indexPath cell的位置
 *  @param leftSpace 下划线左边距
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace{
    
    [self addLineforPlainCell:cell
            forRowAtIndexPath:indexPath
                withLeftSpace:leftSpace
                andRightSpace:0
               hasSectionLine:self.hasSectionLine];
}

/**
 *  为cell添加下划线，左右都有边距
 *
 *  @param cell      cell
 *  @param indexPath cell的位置
 *  @param leftSpace 下划线左边距
 *  @param rightSpace 下划线右边距
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace{

    [self addLineforPlainCell:cell
            forRowAtIndexPath:indexPath
                withLeftSpace:leftSpace
                andRightSpace:rightSpace
               hasSectionLine:self.hasSectionLine];
    
}
#pragma mark - Private Method
/**
 *  为有section的cell添加下划线
 *
 *  @param cell           cell
 *  @param indexPath      indexPath
 *  @param leftSpace      下划线的左边距
 *  @param hasSectionLine section是否有下划线
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell
          forRowAtIndexPath:(NSIndexPath *)indexPath
              withLeftSpace:(CGFloat)leftSpace
              andRightSpace:(CGFloat)rightSpace
             hasSectionLine:(BOOL)hasSectionLine{
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = self.cellLineColor ? self.cellLineColor.CGColor : [UIColor lightGrayColor].CGColor;
    CGColorRef sectionLineColor = self.sectionLineColor ? self.sectionLineColor.CGColor : [UIColor lightGrayColor].CGColor;
    
//    CGColorRef sectionLineColor = self.separatorColor.CGColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer
              addLineUp:YES
                andLong:YES
               andColor:sectionLineColor
              andBounds:bounds
          withLeftSpace:0
          andRightSpace:rightSpace];
            
            [self layer:layer
              addLineUp:NO
                andLong:YES
               andColor:sectionLineColor
              andBounds:bounds
          withLeftSpace:0
          andRightSpace:rightSpace];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer
              addLineUp:YES
                andLong:YES
               andColor:sectionLineColor
              andBounds:bounds
          withLeftSpace:0
          andRightSpace:rightSpace];
        }
        [self layer:layer
          addLineUp:NO
            andLong:NO
           andColor:lineColor
          andBounds:bounds
      withLeftSpace:leftSpace
      andRightSpace:rightSpace];
        
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer
              addLineUp:NO
                andLong:YES
               andColor:sectionLineColor
              andBounds:bounds
          withLeftSpace:0
          andRightSpace:rightSpace];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer
          addLineUp:NO
            andLong:NO
           andColor:lineColor
          andBounds:bounds
      withLeftSpace:leftSpace
      andRightSpace:rightSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

/**
 *  添加下划线的主要方法，使用layer进行下划线的视线
 *
 *  @param layer     原图层
 *  @param isUp      cell的上滑线
 *  @param isLong    是否是撑满全部的长线
 *  @param color     下划线的颜色
 *  @param bounds    cell的高度
 *  @param leftSpace 下划线左边距
 */
- (void)layer:(CALayer *)layer
    addLineUp:(BOOL)isUp
      andLong:(BOOL)isLong
     andColor:(CGColorRef)color
    andBounds:(CGRect)bounds
withLeftSpace:(CGFloat)leftSpace
andRightSpace:(CGFloat)rightSpace{
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top ,right;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
        right = 0;
    }else{
        left = leftSpace;
        right = rightSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left-right, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}

#pragma mark - runtime
// 是否要添加section分割线
- (BOOL)hasSectionLine{

    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setHasSectionLine:(BOOL)hasSectionLine{

    objc_setAssociatedObject(self, @selector(hasSectionLine), @(hasSectionLine), OBJC_ASSOCIATION_ASSIGN);
}
// cell分割线的颜色
- (UIColor *)cellLineColor{

    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCellLineColor:(UIColor *)cellLineColor{

    objc_setAssociatedObject(self, @selector(cellLineColor), cellLineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// section分割线的颜色
-(UIColor *)sectionLineColor{

    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSectionLineColor:(UIColor *)sectionLineColor{

    objc_setAssociatedObject(self, @selector(sectionLineColor), sectionLineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

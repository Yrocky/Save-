//
//  UITableView+Line.h
//  DDXGMarkeProject
//
//  Created by 杨恒 on 16/5/6.
//  Copyright © 2016年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (Line)
/**
 *  是否显示section的分割线
 */
@property (nonatomic ,assign) BOOL hasSectionLine;

/**
 *  cell分割线的颜色
 */
@property (nonatomic ,strong) UIColor * cellLineColor;

/**
 *  section分割线的颜色
 */
@property (nonatomic ,strong) UIColor * sectionLineColor;

/**
 *  为cell添加下划线，左边有边距
 *
 *  @param cell      cell
 *  @param indexPath cell的位置
 *  @param leftSpace 下划线左边距
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell
          forRowAtIndexPath:(NSIndexPath *)indexPath
              withLeftSpace:(CGFloat)leftSpace;

/**
 *  为cell添加下划线，左右都有边距
 *
 *  @param cell      cell
 *  @param indexPath cell的位置
 *  @param leftSpace 下划线左边距
 *  @param rightSpace 下划线右边距
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell
          forRowAtIndexPath:(NSIndexPath *)indexPath
              withLeftSpace:(CGFloat)leftSpace
              andRightSpace:(CGFloat)rightSpace;
@end

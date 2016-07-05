//
//  StoryBoardUtilities.h
//  SimpleMetro
//
//  Created by Youngrocky on 16/5/24.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoryBoardUtilities : NSObject

/**
 *  根据Storyboard以及控制器的id获取控制器实例
 *
 *  @param storyboardName The storyboard file name
 *  @param storyBoardId   The storyboard id
 *
 *  @return UIViewController 实例对象
 */
+ (UIViewController *)viewControllerForStoryboardName:(NSString *)storyboardName storyBoardID:(NSString *)storyBoardId;

/**
 *  这个是上面的一种特殊情况，storyboardID使用的是类的名称
 *
 *  @param storyboardName The storyboard file name
 *  @param class          The view controller's class
 *
 *  @return UIViewController 实例对象
 */
+ (UIViewController *)viewControllerForStoryboardName:(NSString *)storyboardName class:(id)className;

@end

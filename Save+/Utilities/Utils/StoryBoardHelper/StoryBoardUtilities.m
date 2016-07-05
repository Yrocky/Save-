//
//  StoryBoardUtilities.m
//  SimpleMetro
//
//  Created by Youngrocky on 16/5/24.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "StoryBoardUtilities.h"
#import <objc/runtime.h>

@implementation StoryBoardUtilities

+ (UIViewController *)viewControllerForStoryboardName:(NSString *)storyboardName storyBoardID:(NSString *)storyBoardId{

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    UIViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@", storyBoardId]];
    
    return viewController;
}

+ (UIViewController*)viewControllerForStoryboardName:(NSString*)storyboardName class:(id)class
{
    
    NSString* className = nil;
    
    if ([class isKindOfClass:[NSString class]]){
        
        className = [NSString stringWithFormat:@"%@", class];
    }else{
    
        className = [NSString stringWithFormat:@"%s", class_getName([class class])];
    }
    
    return [self viewControllerForStoryboardName:storyboardName storyBoardID:className];
}


@end

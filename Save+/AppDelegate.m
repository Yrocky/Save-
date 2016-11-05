//
//  AppDelegate.m
//  Save+
//
//  Created by Youngrocky on 16/6/17.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "AppDelegate.h"
#import "HLLCategoryHelper.h"
#import "HLLSortCategoryViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    [self.window makeKeyAndVisible];
    
    NSDictionary * att = @{NSForegroundColorAttributeName: kTheme_Color,
                           NSFontAttributeName:[UIFont fontWithName:LATO_BOLD size:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:att];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"84949E"]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
//    [self setupRootViewControllerWithDefaultCategoryConfigure];

    [self loadDefault];
    
    return YES;
}

+ (AppDelegate *)appDelegate{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void) loadDefault{
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    BOOL load = [[userDefault valueForKey:@"loadDefaultCategory"] boolValue];
    
    if (!load) {
        
        [[HLLCategoryHelper shareCategoryHelper] loadDefault];
        
        [self setupRootViewControllerWithDefaultCategoryConfigure];
        
        [userDefault setBool:YES forKey:@"loadDefaultCategory"];
        
        [userDefault synchronize];
    }else{
    
        [self setupRootViewControllerWithCheckViewController];
    }
}

- (void) setupRootViewControllerWithDefaultCategoryConfigure{
    
    HLLSortCategoryViewController * settingCategoryVC = (HLLSortCategoryViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"Check" storyBoardID:ConfigureCategoryViewControllerStoryBoardID];
    settingCategoryVC.defaultSetup = YES;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:settingCategoryVC];
    
    self.window.rootViewController = nav;
}

- (void) setupRootViewControllerWithCheckViewController{
    
    UIViewController * rootViewController = [StoryBoardUtilities viewControllerForStoryboardName:@"Main" storyBoardID:RootNavigationViewControllerStoryBoardID];
    
    self.window.rootViewController = rootViewController;
}


@end

//
//  DefaineManager.h
//  SimpleMetro
//
//  Created by Youngrocky on 16/5/30.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//



#ifndef DefaineManager_h
#define DefaineManager_h

/**
 *  在此处定义宏
 */

// 判断屏幕尺寸
// isLessThenXXX：       e.g，小于iPhone6，iPhone5、iPhone4
// isXXX：               e.g，等于iPhone6
// isGreaterThenXXX：    e.g，大于等于iPhone6，iPhone6、iPhone6 Plus
//
#define isLessThenIPhone4       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width < 640 : NO)
#define isIPhone4               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isGreaterThenIPhone4    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width > 640 : NO)

//
#define isLessThenIPhone5       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width < 640 : NO)
#define isIPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isGreaterThenIPhone5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width > 640 : NO)

//
#define isLessThenIPhone6       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width < 750 : NO)
#define isIPhone6               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isGreaterThenIPhone6    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width > 750  : NO)

//
#define isLessThenIPhone6Plus   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width < 1242 : NO)
#define isIPhone6Plus           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isGreaterThenIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width > 1242 : NO)

// 判断iPad还是iPhone
#define isIPad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 获得工程信息
#define DEF_Version      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DEF_BuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define DEF_AppName      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define DEF_ProjectName  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]

// 获得设备iOS版本
#define IOSVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width  [UIScreen mainScreen].bounds.size.width

#define  LATO_REGULAR   @"Lato-Regular"
#define  LATO_BOLD      @"Lato-Bold"
#define  LATO_HAIRLINE  @"Lato-Hairline"
#define  LATO_THIN      @"Lato-Thin"
#define  LATO_LIGHT     @"Lato-Light"
#define  LATO_THIN_IT   @"Lato-ThinItalic"

#define kTheme_Color    [UIColor colorWithHexString:@"21AF73"]
#define kGray_Color     [UIColor colorWithHexString:@"6F818D"]
#define kLine_Color     [[UIColor lightGrayColor] colorWithAlphaComponent:0.25]


#define OnePixel 1 / [UIScreen mainScreen].scale
#endif /* DefaineManager_h */

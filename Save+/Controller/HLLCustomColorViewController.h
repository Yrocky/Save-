//
//  HLLCustomColorViewController.h
//  Save+
//
//  Created by Rocky Young on 16/11/4.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomColorPickerData)(NSString * categoryName,NSString *categoryColor);

@interface HLLCustomColorViewController : UIViewController

@property (nonatomic ,copy) CustomColorPickerData customHandle;

@property (nonatomic ,strong) NSString * categoryName;
@property (nonatomic ,strong) NSString * categoryColor;
@property (nonatomic ,strong) NSString * categoryIcon;
@end

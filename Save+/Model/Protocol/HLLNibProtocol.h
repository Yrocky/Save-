//
//  HLLNibProtocol.h
//  Save+
//
//  Created by Youngrocky on 16/6/21.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//
//  通用与使用Xib进行布局加载视图的UIView或者其子类，
//
//  包括UITableViewCell和UIContainerViewCell，但是不推荐使用
//
//  如果是这两个使用专门的`HLLNibCellProtocol`协议
//
#import <Foundation/Foundation.h>

@protocol HLLNibProtocol <NSObject>

@required

+ (instancetype) hll_loadWithNib;

+ (NSString *) hll_nibName;

@optional

@end

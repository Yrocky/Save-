//
//  ZASyncURLConnection.h
//  ARC-Blocks-GCD
//
//  Created by mapboo on 4/10/14.
//  Copyright (c) 2014 mapboo. All rights reserved.
//  BLOG: http://blog.csdn.net/mapboo
//  QQ GROUP: 262091386（iOS中国开发者）

#import <Foundation/Foundation.h>

/*
    本库结合ARC，Blocks和GCD 来实现了一个下载的封装，目的是更好的理解这些新特性的使用
 
    操作非常简单，使用方法如下:
 
    [ZASyncURLConnection request:imgURL completeBlock:^(NSData *data) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *img = [UIImage imageWithData:data];
        UIImageView *imgView = (UIImageView *)[self.view viewWithTag:10];
        imgView.image = img;
    });

    } errorBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];

 */

/*
 * typedef Block 类型变量
 * 提高源代码的可读性
 */

typedef void(^CompleteBlock_t)(NSData *data);
typedef void(^ErrorBlock_t)(NSError *error);

@interface ZASyncURLConnection : NSURLConnection<NSURLConnectionDataDelegate>
{
    NSMutableData *data_;
    CompleteBlock_t completeBlock_;
    ErrorBlock_t errorBlock_;
}

+ (id)request:(NSString *)requestUrl completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock;

- (id)initWithRequest:(NSString *)requestUrl completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock;

@end

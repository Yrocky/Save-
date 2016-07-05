//
//  LocationManager.h
//  Save+
//
//  Created by Youngrocky on 16/7/1.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <Foundation/Foundation.h>


@import CoreLocation;
@class LocationManager;

@protocol LocationManagerDelegate <NSObject>

@optional

// 定位成功
- (void)locationManager:(LocationManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location;

// 定位失败
- (void)locationManager:(LocationManager *)manager didFailed:(NSError *)error;

// 没有开启定位信息
- (void)locationManagerServerClosed:(LocationManager *)manager;

@end
@interface LocationManager : NSObject

@property (nonatomic, weak)     id<LocationManagerDelegate> delegate;

@property (nonatomic, readonly) CLAuthorizationStatus          authorizationStatus;

- (void)start;
@end



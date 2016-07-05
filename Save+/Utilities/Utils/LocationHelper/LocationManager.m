//
//  LocationManager.m
//  Save+
//
//  Created by Youngrocky on 16/7/1.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locationManager          = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // 适配iOS8，iOS7以及以下没有这方法
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}
- (void)start {
    
    [_locationManager startUpdatingLocation];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [manager stopUpdatingLocation];
    
    if (_delegate && [_delegate respondsToSelector:@selector(locationManager:didUpdateAndGetLastCLLocation:)]) {
        //        LOG_DEBUG(@"updateLocation++++++++");
        CLLocation *location = [locations lastObject];
        [_delegate locationManager:self didUpdateAndGetLastCLLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    //    LOG_DEBUG(@"定位失败");
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        //        LOG_DEBUG(@"定位功能关闭");
        if (_delegate && [_delegate respondsToSelector:@selector(locationManagerServerClosed:)]) {
            
            [_delegate locationManagerServerClosed:self];
        }
        
    } else {
        
        //        LOG_DEBUG(@"定位功能失败");
        if (_delegate && [_delegate respondsToSelector:@selector(locationManager:didFailed:)]) {
            
            //            LOG_DEBUG(@"%@", error);
            [_delegate locationManager:self didFailed:error];
        }
    }
}

@synthesize authorizationStatus = _authorizationStatus;

- (CLAuthorizationStatus)authorizationStatus {
    
    return [CLLocationManager authorizationStatus];
}


@end

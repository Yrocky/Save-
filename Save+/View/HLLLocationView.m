//
//  HLLLocationView.m
//  Save+
//
//  Created by Youngrocky on 16/7/4.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import "HLLLocationView.h"
#import "GPSLocationManager.h"
#import "ZASyncURLConnection.h"
#import "UIImage+ImageEffects.h"
#import "MHLocationConverter.h"


@interface HLLLocationView ()

@property (nonatomic ,strong) IBOutlet UIImageView * backgroundMapImageView;
@property (nonatomic ,strong) IBOutlet UIImageView * iconImageView;

@property (nonatomic ,strong) IBOutlet UILabel * locationInfoLabel;

@property (nonatomic ,strong ,readwrite) NSString * loctionInfo;
@property (nonatomic ,assign ,readwrite) CGFloat longitude;
@property (nonatomic ,assign ,readwrite) CGFloat latitude;
@end
@implementation HLLLocationView

- (void)awakeFromNib{

    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.backgroundMapImageView.layer.cornerRadius = 10.0f;
    self.backgroundMapImageView.layer.masksToBounds = YES;
    
    self.iconImageView.backgroundColor = [UIColor clearColor];
    
    self.locationInfoLabel.textColor = kTheme_Color;
    self.locationInfoLabel.backgroundColor = [UIColor clearColor];
    self.locationInfoLabel.text = @"定位中....";
}

#pragma mark - HLLNibProtocol

+ (instancetype)hll_loadWithNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:[HLLLocationView hll_nibName] owner:self options:nil] firstObject];
}

+ (NSString *)hll_nibName{
    
    return @"HLLLocationView";
}

#pragma mark - HLLAnimationProtocol

- (void)showAnimaiton{

    self.alpha = 0.0f;
    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenAnimation{

    [UIView animateWithDuration:CommonAnimationDeration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.alpha = .0f;
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - API

- (void) loadCurrentLocationInfo{
    // 防止循环引用
    __unsafe_unretained typeof([GPSLocationManager sharedGPSLocationManager]) gps = [GPSLocationManager sharedGPSLocationManager];
    
    // 开启定位
    [gps startGPSLocation];
    
    // 定位结果
    gps.gpsFailureBlock = ^() {
        // 定位失败
        self.locationInfoLabel.text = @"定位失败，请确认是否已开启定位设置";
    };
    
    gps.gpsSuccessBlock = ^(CLLocationDistance longitude, CLLocationDistance latitude) {
        
        // 停止定位
        [gps stopGPSLocation];
        
        self.longitude = longitude;
        self.latitude = latitude;
        
        // 定位成功
        self.locationInfoLabel.text = @"定位成功，解析位置信息....";
        
        // 获取位置截图
        [self loadMapImageWithLatitude:latitude andLongitude:longitude];
        
        // 逆编译地区
        [gps gpsLocationInfoByLong:longitude lat:latitude locationInfo:^(CLPlacemark *gpsInfo) {
            
//            NSLog(@"当前地理位置信息: %@", gpsInfo);
            
            self.locationInfoLabel.text = gpsInfo.name;
            
            self.loctionInfo = gpsInfo.name;
        }];
    };
}

#pragma mark - Method

- (void) loadMapImageWithLatitude:(CLLocationDistance)latitude andLongitude:(CLLocationDistance) longitude{
    
    CLLocationCoordinate2D oldCoord = CLLocationCoordinate2DMake(latitude, longitude);
    
    CLLocationCoordinate2D newCoord = [MHLocationConverter bd09ToGcj02:oldCoord];
    
    //根据经纬度获得地图截图
    NSString * GDKEY = @"0a89b45d22684870ae17c1592a89f6b3";
    NSString * urlString = [NSString stringWithFormat:@"http://restapi.amap.com/v3/staticmap?location=%f,%f&zoom=19&size=1000*600&markers=mid,,A:%f,%f&key=%@",newCoord.longitude,newCoord.latitude,newCoord.longitude,newCoord.latitude,GDKEY];
    
    [ZASyncURLConnection request:urlString completeBlock:^(NSData *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage * image = [UIImage imageWithData:data] ;
            UIImage * effectImage = [image applyBlurWithRadius:0.
                                                     tintColor:[UIColor colorWithWhite:0 alpha:0.5]
                                         saturationDeltaFactor:1.4
                                                     maskImage:nil];
            
            self.backgroundMapImageView.image = effectImage;
            self.iconImageView.hidden = YES;
        });
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}
@end

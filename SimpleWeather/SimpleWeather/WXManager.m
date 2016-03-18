//
//  WXManager.m
//  SimpleWeather
//
//  Created by 王享 on 16/3/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "WXManager.h"

#import "WXClient.h"
#import "TSMessage.h"
#import "SVProgressHUD.h"

@interface WXManager ()

// 1
@property (nonatomic, strong, readwrite) WXCondition *currentCondition;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong, readwrite) NSArray *hourlyForecast;
@property (nonatomic, strong, readwrite) NSArray *dailyForecast;

// 2
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) WXClient *client;

@end

@implementation WXManager

+(instancetype)sharedManager{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc]init];
    });
    return _sharedManager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _locationManager =[[CLLocationManager alloc]init];
        _locationManager.delegate=self;
        
        _client =[[WXClient alloc]init];
        [[[[RACObserve(self, currentCondition) ignore:nil] flattenMap:^RACStream *(CLLocation *newLocation) {
            // Flatten and subscribe to all 3 signals when currentLocation updates
            return [RACSignal merge:@[
                                      [self updateCurrentConditions],
                                      [self updateDailyForecast],
                                      [self updateHourlyForecast]
                                      ]
                    ];
        }] deliverOn:RACScheduler.mainThreadScheduler]
        subscribeError:^(NSError *error) {
            [TSMessage showNotificationWithTitle:@"Error"
                                        subtitle:@"There was a problem fetching the latest weather"type:TSMessageNotificationTypeError];
        }];
    }
    return self;
}

- (void)findCurrentLocation{
    self.isFirstUpdate = YES;
    [self startLocation];
}
- (void)startLocation{
    // 1） 实例化定位管理器
    _locationManager = [[CLLocationManager alloc]init];
    // 2) 设置定位管理器的代理
    [_locationManager setDelegate:self];
    // 3) 设置定位管理器的精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    if (![CLLocationManager locationServicesEnabled]) {
        [SVProgressHUD showErrorWithStatus:@"定位服务已关闭，请前往设置页面打开"];
    }else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){//如果没有授权则请求用户授权
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        // 5) 开启用户定位功能
        [_locationManager startUpdatingLocation];
    } else {
        [SVProgressHUD showErrorWithStatus:@"没有开启定位服务"];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return ;
    }
    CLLocation *location = [locations lastObject];
    if (location.horizontalAccuracy >= 0) {
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"定位失败"];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusNotDetermined:
            [_locationManager requestWhenInUseAuthorization];
        default:
            break;
    }
}


- (RACSignal *)updateCurrentConditions {
    return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate] doNext:^(WXCondition *condition) {
        self.currentCondition = condition;
    }];
}

- (RACSignal *)updateHourlyForecast {
    return [[self.client fetchHourlyForecastForLocation:self.currentLocation.coordinate] doNext:^(NSArray *conditions) {
        self.hourlyForecast = conditions;
    }];
}

- (RACSignal *)updateDailyForecast {
    return [[self.client fetchDailyForecastForLocation:self.currentLocation.coordinate] doNext:^(NSArray *conditions) {
        self.dailyForecast = conditions;
    }];
}


@end

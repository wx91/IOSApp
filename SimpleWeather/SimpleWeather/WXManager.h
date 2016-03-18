//
//  WXManager.h
//  SimpleWeather
//
//  Created by 王享 on 16/3/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import <CoreLocation/CoreLocation.h>
#import "WXCondition.h"

@interface WXManager : NSObject<CLLocationManagerDelegate>

+(instancetype)sharedManager;

// 3
@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WXCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

// 4
- (void)findCurrentLocation;


@end

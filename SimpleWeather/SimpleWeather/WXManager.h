//
//  WXManager.h
//  SimpleWeather
//
//  Created by 王享 on 16/2/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ReactiveCocoa.h"
#import "WXCondition.h"


@interface WXManager : NSObject<CLLocationManagerDelegate>



@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WXCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

+(instancetype)sharedManager;

- (void)findCurrentLocation;

@end

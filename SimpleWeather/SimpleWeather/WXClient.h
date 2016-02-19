//
//  WXClient.h
//  SimpleWeather
//
//  Created by 王享 on 16/2/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ReactiveCocoa.h"

@interface WXClient : NSObject

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;

- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate;

- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate;

- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate;

@end

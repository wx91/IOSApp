//
//  WXWeatherModel.m
//  SimpleWeather1
//
//  Created by 王享 on 16/3/22.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "WXWeatherModel.h"

@implementation WXWeatherModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"weatherId":@"id",
             @"weatherDescription":@"description",
             };
}
+ (NSDictionary *)imageMap {
    // 1
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        // 2
        _imageMap = @{
                      @"01d" : @"weather-clear",
                      @"02d" : @"weather-few",
                      @"03d" : @"weather-few",
                      @"04d" : @"weather-broken",
                      @"09d" : @"weather-shower",
                      @"10d" : @"weather-rain",
                      @"11d" : @"weather-tstorm",
                      @"13d" : @"weather-snow",
                      @"50d" : @"weather-mist",
                      @"01n" : @"weather-moon",
                      @"02n" : @"weather-few-night",
                      @"03n" : @"weather-few-night",
                      @"04n" : @"weather-broken",
                      @"09n" : @"weather-shower",
                      @"10n" : @"weather-rain-night",
                      @"11n" : @"weather-tstorm",
                      @"13n" : @"weather-snow",
                      @"50n" : @"weather-mist",
                      };
    }
    return _imageMap;
}
- (NSString *)imageName {
    return [WXWeatherModel imageMap][self.icon];
}


@end

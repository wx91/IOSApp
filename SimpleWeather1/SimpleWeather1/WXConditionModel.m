//
//  WXCondition.m
//  SimpleWeather
//
//  Created by 王享 on 16/3/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "WXConditionModel.h"
#import "WXWeatherModel.h"

#define MPS_TO_MPH 2.23694f


@implementation WXConditionModel



+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed"
             };
}

+(NSValueTransformer *)dateJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSString *str, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
    } reverseBlock:^(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
}

+ (NSValueTransformer *)sunriseJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer {
    return [self dateJSONTransformer];
}

+(NSValueTransformer *)weatherTransformer{
    return [NSValueTransformer mtl_validatingTransformerForClass:[WXWeatherModel class]];
}


-(NSValueTransformer *)windSpeedJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *num, BOOL *success, NSError *__autoreleasing *error) {
        return @(num.floatValue*MPS_TO_MPH);
    } reverseBlock:^(NSNumber *speed, BOOL *success, NSError *__autoreleasing *error) {
        return @(speed.floatValue/MPS_TO_MPH);
    }];
}


@end

//
//  WXCondition.h
//  SimpleWeather
//
//  Created by 王享 on 16/3/18.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface WXConditionModel : MTLModel<MTLJSONSerializing>
/**
 *  当前日期
 */
@property (nonatomic, strong) NSDate *date;
/**
 *  气压
 */
@property (nonatomic, strong) NSNumber *humidity;
/**
 *  温度
 */
@property (nonatomic, strong) NSNumber *temperature;
/**
 *  最高气温
 */
@property (nonatomic, strong) NSNumber *tempHigh;
/**
 *  最低气温
 */
@property (nonatomic, strong) NSNumber *tempLow;
/**
 *  所在城市
 */
@property (nonatomic, strong) NSString *locationName;
/**
 *  日出
 */
@property (nonatomic, strong) NSDate *sunrise;
/**
 *  日落
 */
@property (nonatomic, strong) NSDate *sunset;

/**
 *  风压
 */
@property (nonatomic, strong) NSNumber *windBearing;
/**
 *  风速
 */
@property (nonatomic, strong) NSNumber *windSpeed;
/**
 *  天气数组
 */
@property (nonatomic, strong) NSMutableArray *weather;

@end

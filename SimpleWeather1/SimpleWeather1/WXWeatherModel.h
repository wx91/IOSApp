//
//  WXWeatherModel.h
//  SimpleWeather1
//
//  Created by 王享 on 16/3/22.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXWeatherModel : NSObject

@property (nonatomic, strong) NSNumber *weatherId;

@property (nonatomic, strong) NSString *main;

@property (nonatomic, copy) NSString *weatherDescription;

@property (nonatomic, copy) NSString *icon;

- (NSString *)imageName;

@end

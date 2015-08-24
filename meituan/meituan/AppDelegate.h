//
//  AppDelegate.h
//  meituan
//
//  Created by wangx on 15/8/24.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    //用于获取位置
    CLLocationManager       *_locationManager;
    //用于保存位置信息
    CLLocation              *_checkLocation;
}

@property (strong, nonatomic) UIWindow *window;

//经度
@property (nonatomic, assign) double longitude;
//纬度
@property (nonatomic, assign) double latitude;




@end


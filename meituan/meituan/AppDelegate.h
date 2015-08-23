//
//  AppDelegate.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

/**按照作者ljz的源代码进行编写的
 *  作者：ljz
 *  Q Q：863784757
 *  注明：版权所有，转载请注明出处，不可用于其他商业用途。
 */


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


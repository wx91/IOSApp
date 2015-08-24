//
//  JZMapViewControlle.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#import "NetworkSingleton.h"
#import "CustomAnnotationView.h"
#import "JZMAAroundAnnotation.h"
#import "JZMAAroundModel.h"
#import "MJExtension.h"
#import <CoreLocation/CoreLocation.h>

#define kDefaultCalloutViewMargin       -8
#define MAPKEY @"2812f1e8b5f3c1473e8928ae9130e63d"
@interface JZMapViewControlle : UIViewController<MAMapViewDelegate,AMapSearchDelegate>{
    MAMapView *_mapView;
    UIButton *_locationBtn;//定位按钮
    
    //地址转码
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    
    //附近搜索数据
    NSMutableArray *_pois;
    NSMutableArray *_annotations;
}

@end

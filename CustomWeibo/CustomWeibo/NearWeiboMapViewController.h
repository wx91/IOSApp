//
//  NearWeiboMapViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NearWeiboMapViewController : BaseViewController<CLLocationManagerDelegate,WBHttpRequestDelegate,MKMapViewDelegate>
@property(nonatomic,retain)NSArray *data;

@property(nonatomic,strong)CLLocationManager *locationManager;

@property(strong,nonatomic) IBOutlet MKMapView *mapView;

@end

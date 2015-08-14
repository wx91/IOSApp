//
//  WeiboAnnotation.h
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Status.h"

@interface WeiboAnnotation : NSObject<MKAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;

@property(nonatomic,retain)Status *weiboModel;
//--optional--
@property(nonatomic,readonly,copy)NSString *title;
@property(nonatomic,readonly,copy)NSString *subtitle;

-(instancetype)initWithWeibo:(Status *)weiboModel;

@end

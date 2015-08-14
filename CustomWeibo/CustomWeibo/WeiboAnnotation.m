//
//  WeiboAnnotation.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation

-(instancetype)initWithWeibo:(Status *)weiboModel{
    self=[super init];
    if (self) {
        self.weiboModel=weiboModel;
    }
    return self;
}
-(void)setWeiboModel:(Status *)weiboModel{
    if (_weiboModel!=weiboModel) {
        _weiboModel=weiboModel;
    }
    //
    NSDictionary *geo=weiboModel.geo;
    if ([geo isKindOfClass:[NSDictionary class]]) {
        NSArray *coord=[geo objectForKey:@"coordinates"];
        if (coord.count==2) {
            CLLocationDegrees lat=[[coord objectAtIndex:0]doubleValue];
            CLLocationDegrees lon=[[coord objectAtIndex:0]doubleValue];
            _coordinate=CLLocationCoordinate2DMake(lat,lon);
        }
    }
}


@end

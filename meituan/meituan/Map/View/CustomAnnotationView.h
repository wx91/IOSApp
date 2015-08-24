//
//  CustomAnnotationView.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "JZMAAroundAnnotation.h"
#import "CustomCalloutView.h"

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0


@interface CustomAnnotationView : MAAnnotationView

@property(nonatomic, strong) CustomCalloutView *calloutView;

@property(nonatomic,strong)JZMAAroundAnnotation *jzAnnotation;


@end

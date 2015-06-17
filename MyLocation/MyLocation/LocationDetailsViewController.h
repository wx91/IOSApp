//
//  LocationDetailsViewController.h
//  MyLocation
//
//  Created by wangx on 15/5/3.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDetailsViewController:UITableViewController<UITextViewDelegate>

@property(nonatomic,weak) IBOutlet UITextView *descriptionTextView;

@property(nonatomic,weak) IBOutlet UILabel *categoryLabel;

@property(nonatomic,weak) IBOutlet UILabel *latitudeLabel;

@property(nonatomic,weak) IBOutlet UILabel *longitudeLabel;

@property(nonatomic,weak) IBOutlet UILabel *addressLabel;

@property(nonatomic,weak) IBOutlet UILabel *dateLabel;


@property(nonatomic,assign)CLLocationCoordinate2D coordinate;

@property(nonatomic,strong) CLPlacemark *placemark;

@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;


@end

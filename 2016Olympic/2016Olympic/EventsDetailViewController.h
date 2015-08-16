//
//  EventsDetailViewController.h
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Events.h"

@interface EventsDetailViewController : UIViewController

@property(nonatomic,strong)Events *event;

@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *lblEventName;

@property (weak, nonatomic) IBOutlet UIImageView *imgEventIcon;

@property (weak, nonatomic) IBOutlet UITextView *txtViewKeyInfo;

@property (weak, nonatomic) IBOutlet UITextView *txtViewBasicsInfo;

@property (weak, nonatomic) IBOutlet UITextView *txtViewOlympicInfo;

@end

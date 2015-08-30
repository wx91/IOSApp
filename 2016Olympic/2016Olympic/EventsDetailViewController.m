//
//  EventsDetailViewController.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "EventsDetailViewController.h"

@implementation EventsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详细信息";
    
    self.imgEventIcon.image = [UIImage imageNamed:self.event.EventIcon];
    self.lblEventName.text = self.event.EventName;
    self.txtViewBasicsInfo.text = self.event.BasicsInfo;
    self.txtViewKeyInfo.text = self.event.KeyInfo;
    self.txtViewOlympicInfo.text = self.event.OlympicInfo;
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentInset = UIEdgeInsetsMake(-50,0,0,0); //top, left, bottom, right;
    self.scrollView.contentSize = CGSizeMake(320, 100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

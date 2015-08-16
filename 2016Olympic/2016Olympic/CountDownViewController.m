//
//  CountDownViewController.m
//  2016Olympic
//
//  Created by wangx on 15/8/16.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CountDownViewController.h"


@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建NSDateComponents对象
    NSDateComponents *comps=[[NSDateComponents alloc]init];
    //设置NSDateComponents日期
    [comps setDay:5];
    //设置NSDateComponents月
    [comps setMonth:8];
    //设置NSDateComponents年
    [comps setYear:2016];
    //创建日历对象
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    //获得2016-8-5日的NSDate日期对象
    NSDate *destinationDate=[calendar dateFromComponents:comps];
    //获得当前日期到2016-8-5时间的NSDateComponents对象
    NSDateComponents *components=[calendar components:NSCalendarUnitDay fromDate:[NSDate date] toDate:destinationDate options:NSCalendarWrapComponents];
    //获取当前日期到2016-8-5相差的天数
    int days=[components day];
    NSMutableAttributedString *attributedTextHolder =
    [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i天",days]];

    [attributedTextHolder addAttribute:NSFontAttributeName
                                 value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
                                 range:NSMakeRange(attributedTextHolder.length - 1, 1)];

    self.labelCountDown.attributedText = attributedTextHolder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

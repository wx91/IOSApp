//
//  MainViewController.m
//  HelloWorld
//
//  Created by wangx on 15/8/31.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)initView{
    
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor=[UIColor redColor];
//    button.frame=CGRectMake(0, 20, 60, 44);
//    button.titleLabel.font=[UIFont systemFontOfSize:14];
//    button.lineBreakMode=NSLineBreakByTruncatingTail;
//    [button setTitle:@"克拉玛" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"icon-map"] forState:UIControlStateNormal];
//    [self.view addSubview:button];
////    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
//    item.style=UIBarButtonItemStyleBordered;
//    [item setBackgroundVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.leftBarButtonItem=item;
//    NSDictionary *result=@{@"flag":@"0"};
//    NSInteger status=[[result objectForKey:@"flag"] integerValue];
//    NSLog(@"1232");
    UILabel *noteLabel=[[UILabel alloc]init];
    noteLabel.frame=CGRectMake(10, 100, 200, 100);
    noteLabel.textColor=[UIColor blackColor];
    NSMutableAttributedString *noteStr=[[NSMutableAttributedString alloc]initWithString:@"111:222"];
    NSRange redRange=NSMakeRange(0,[[noteStr string]rangeOfString:@":"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [noteLabel setAttributedText:noteStr];
    [noteLabel sizeToFit];
    [self.view addSubview:noteLabel];
    
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

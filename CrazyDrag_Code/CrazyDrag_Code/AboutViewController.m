//
//  AboutViewController.m
//  CrazyDrag_Code
//
//  Created by wangx on 15/6/15.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

-(void)loadView{
    UIView *view=[[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    self.view=view;
    
    //设置背景图片
    
    UIImageView *backgroundView=[[UIImageView alloc]init];
    backgroundView.frame=[[UIScreen mainScreen]applicationFrame];
    backgroundView.image=[UIImage imageNamed:@"Background"];
    [self.view addSubview:backgroundView];
    
    UITextView *tv=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 480, 200)];
    tv.text=@"欢迎加⼊入⼟土豪俱乐部!修炼⼟土豪真⾦金的⽅方式很简单,你只需要拖动界⾯面中的滑动条就好了。!你的⽬目标是让滑动条的结点尽可能接近预设的分数,越接近表⽰示你的⼟土豪成分越⾼高。欢迎 获取真⾦金!";
    [self.view addSubview:tv];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(0, 250, 480, 50);
    button.backgroundColor=[UIColor yellowColor];
    [button setTitle:@"关闭当前页面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)close{
    [self.presentingViewController dismissViewControllerAnimated: YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  DiscoverViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearWeiboMapViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"广场";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for(int i= 100;i<=101;i++){
        UIButton *button =  (UIButton *)[self.view viewWithTag:i];
        button.layer.shadowColor =  [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(2, 2); //阴影的大小
        button.layer.shadowOpacity =  1;  //不透明
        button.layer.shadowRadius =  3;
    }
}


#pragma mark action

- (IBAction)nearUser:(id)sender {
    
}

- (IBAction)nearWeibo:(id)sender {
    NearWeiboMapViewController *nearWeibo = [[NearWeiboMapViewController alloc]init];
    [self.navigationController pushViewController:nearWeibo animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end

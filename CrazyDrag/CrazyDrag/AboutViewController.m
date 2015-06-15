//
//  AboutViewController.m
//  CrazyDrag
//
//  Created by wangx on 15/3/27.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated: YES completion:nil];
}


@end

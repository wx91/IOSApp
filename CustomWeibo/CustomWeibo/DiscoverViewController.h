//
//  DiscoverViewController.h
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"

@interface DiscoverViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *nearUser;
@property (strong, nonatomic) IBOutlet UIButton *nearWeibo;
- (IBAction)nearUser:(id)sender;
- (IBAction)nearWeibo:(id)sender;

@end

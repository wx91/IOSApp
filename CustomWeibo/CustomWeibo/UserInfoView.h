//
//  UserInfoViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/12.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RectButton.h"
#import "User.h"

@interface UserInfoView : UIView

@property (nonatomic,retain)User *user;


@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet RectButton *addButton;
@property (strong, nonatomic) IBOutlet RectButton *fansButton;


- (IBAction)followAction:(id)sender;
- (IBAction)fansAction:(id)sender;


@end

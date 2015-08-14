//
//  UserGridView.h
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserGridView : UIView

@property(nonatomic,retain)User *userModel;
@property(nonatomic,strong)IBOutlet UILabel *nickLabel;
@property(nonatomic,strong)IBOutlet UILabel *fansLabel;
@property(nonatomic,strong)IBOutlet UIButton *imageButton;

-(IBAction)userImageAction:(id)sender;


@end

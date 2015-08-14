//
//  UserGridView.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "UserGridView.h"
#import "ProfileViewController.h"
#import "UIButton+WebCache.h"
#import "UIViewExt.h"
#import "UserViewController.h"
#import "UIView+Extra.h"


@implementation UserGridView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIView *gridView=[[[NSBundle mainBundle]loadNibNamed:@"UserGridView" owner:self options:nil]lastObject];
        gridView.backgroundColor=[UIColor clearColor];
        self.size=gridView.size;
        [self addSubview:gridView];
        
        UIImage *image=[UIImage imageNamed:@"profile_button3_1"];
        UIImageView *backgroundView=[[UIImageView alloc]initWithImage:image];
        backgroundView.frame=self.bounds;
        [self insertSubview:backgroundView atIndex:0];//0是底部
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //昵称
    self.nickLabel.text=self.userModel.screen_name;
    
    //粉丝
    long follower=[self.userModel.followers_count longLongValue];
    NSString *followerString=[NSString stringWithFormat:@"%ld",follower];
    if (follower>10000) {
        followerString = [NSString stringWithFormat:@"%ld万",follower/10000];
    }
    self.fansLabel.text = followerString;
    
    NSString *url=self.userModel.profile_image_url;
    NSURL *stringUrl=[NSURL URLWithString:url];
    [self.imageButton sd_setImageWithURL:stringUrl forState:UIControlStateNormal];
}
-(IBAction)userImageAction:(id)sender{
    UserViewController *userViewController=[[UserViewController alloc]init];
    userViewController.userName=self.userModel.screen_name;
    [self.viewController.navigationController pushViewController:userViewController animated:YES];
}
@end

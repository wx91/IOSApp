//
//  WeiboAnnotationView.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"

@implementation WeiboAnnotationView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

-(void)initView{
    userImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    userImage.layer.borderColor=[UIColor whiteColor].CGColor;
    userImage.layer.borderWidth=1;
    
    weiboImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    weiboImage.backgroundColor= [UIColor blackColor];
    weiboImage.contentMode=UIViewContentModeScaleAspectFit;//不会被拉伸
    
    textLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    textLabel.font=[UIFont systemFontOfSize:16.0f];
    textLabel.textColor=[UIColor whiteColor];
    textLabel.backgroundColor=[UIColor clearColor];
    textLabel.numberOfLines=3;
    
    [self addSubview:userImage];
    [self addSubview:weiboImage];
    [self addSubview:textLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    WeiboAnnotation *annotion=self.annotation;
    Status *weiboModel=nil;
    if ([annotion isKindOfClass:[WeiboAnnotation class]]) {
        weiboModel=annotion.weiboModel;
    }
    NSString *thumbnailImage=weiboModel.thumbnailImage;
    if (thumbnailImage.length>0) {
        //带图片微博
        self.image=[UIImage imageNamed:@"nearby_map_photo_bg"];
        
        weiboImage.frame=CGRectMake(15, 15, 90, 85);
        [weiboImage sd_setImageWithURL:[NSURL URLWithString:thumbnailImage]];
        
        userImage.frame=CGRectMake(70, 79, 30, 30);
        NSString *userURL=weiboModel.user.profile_image_url;
        [userImage sd_setImageWithURL:[NSURL URLWithString:userURL]];
        
        weiboImage.hidden=NO;
        textLabel.hidden=YES;
    }else{
        //不带图片的微博
        self.image=[UIImage imageNamed:@"nearby_map_content"];
        userImage.frame=CGRectMake(20, 20, 45, 45);
        NSString *userURL=weiboModel.user.profile_image_url;
        [userImage sd_setImageWithURL:[NSURL URLWithString:userURL]];
        
        textLabel.frame=CGRectMake(userImage.right + 5, userImage.top, 110, 45);
        textLabel.text=weiboModel.text;
        
        weiboImage.hidden=YES;
        textLabel.hidden=NO;
    }
}

@end

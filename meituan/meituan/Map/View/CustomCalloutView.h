//
//  CustomCalloutView.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kArrorHeight        10

#define kPortraitMargin 5

#define kImageWidth 70
#define kImageHeight 50

#define kTitleWidth         120
#define kTitleHeight        20
@interface CustomCalloutView : UIView{
    UILabel *_titleLabel;
    UILabel *_subtitleLabel;
}

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *subtitle;

@property(nonatomic, strong) UIImageView *imageView;

@end

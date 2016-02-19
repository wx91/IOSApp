//
//  WXController.h
//  SimpleWeather
//
//  Created by 王享 on 16/2/19.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LBBlurredImage.h"

@interface WXController : UIViewController

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *blurredImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat screenHeight;

@end

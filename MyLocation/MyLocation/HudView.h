//
//  HudView.h
//  MyLocation
//
//  Created by wangx on 15/5/3.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView
@property(nonatomic,strong) NSString *text;
+(instancetype)hudInView:(UIView *)view animated:(BOOL) animated;
@end

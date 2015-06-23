//
//  RootViewController.h
//  CrazyDrag_Code
//
//  Created by wangx on 15/6/15.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RootViewController : UIViewController

@property(strong,nonatomic) UISlider *slider;

@property(strong,nonatomic) UILabel *targetLabel;

@property(strong,nonatomic) UILabel *scoreLabel;

@property(strong,nonatomic) UILabel *roundLabel;

@property(strong,nonatomic) AVAudioPlayer *audioPlayer;


@end

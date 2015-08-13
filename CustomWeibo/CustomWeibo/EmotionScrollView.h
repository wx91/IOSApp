//
//  EmotionScrollView.h
//  CustomWeibo
//
//  Created by wangx on 15/8/13.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionView.h"

@interface EmotionScrollView : UIView<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    EmotionView  *emotionView;
    UIPageControl *pageControl;
}
-(instancetype)initwithSelectBlock:(SelectBlock)block;


@end

//
//  ImageScrollView.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageScrollViewDelegate <NSObject>

-(void)didSelectImageAtIndex:(NSInteger)index;

@end

@interface ImageScrollView : UIView<UIScrollViewDelegate>{
    NSTimer *_timer;
    int _pageNumber;
}

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) NSArray *imgArray;
@property(nonatomic, assign) id<ImageScrollViewDelegate> delegate;

-(void)setImageArray:(NSArray *)imageArray;

-(ImageScrollView *)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imgArr;

@end

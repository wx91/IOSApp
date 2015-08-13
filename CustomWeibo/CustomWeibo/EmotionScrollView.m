//
//  EmotionScrollView.m
//  CustomWeibo
//
//  Created by wangx on 15/8/13.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "EmotionScrollView.h"
#import "Constant.h"
#import "UIViewExt.h"

@implementation EmotionScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(instancetype)initwithSelectBlock:(SelectBlock)block{
    if ([self initWithFrame:CGRectZero]) {
        emotionView.block=block;
    }
    return self;
}

-(void)initView{
    emotionView=[[EmotionView alloc]initWithFrame:CGRectZero];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, emotionView.height)];
    NSLog(@"emotionView.height:%f",emotionView.height);
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.contentSize=CGSizeMake(emotionView.width, 0);
    scrollView.alwaysBounceVertical=NO;
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.clipsToBounds=NO;
    scrollView.delegate=self;
    
    [scrollView addSubview:emotionView];
    [self addSubview:scrollView];
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(-15, scrollView.bottom, 40, 20)];
    pageControl.backgroundColor=[UIColor clearColor];
    pageControl.numberOfPages=emotionView.pageNumber;
    pageControl.currentPage=0;
    [self addSubview:pageControl];
    
    self.height=scrollView.height+pageControl.height;
    self.width=scrollView.width;
}

-(void)drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"emoticon_keyboard_background.png"]drawInRect:rect];
}
#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    int pageNumber=_scrollView.contentOffset.x/ScreenWidth;
    pageControl.currentPage=pageNumber;
}

@end

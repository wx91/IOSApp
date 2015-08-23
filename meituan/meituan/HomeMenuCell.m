//
//  HomeMenuCell.m
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "HomeMenuCell.h"
#import "JZMTBtnView.h"
#import "Constant.h"

@implementation HomeMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews:menuArray];
    }
    return self;
}
-(void)initViews:(NSMutableArray *)menuArray{
    //
    _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
    _backView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 180)];
    scrollView.contentSize = CGSizeMake(2*screen_width, 180);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [scrollView addSubview:_backView1];
    [scrollView addSubview:_backView2];
    [self addSubview:scrollView];
    
    //创建8个
    for (int i = 0; i < 16; i++) {
        if (i < 4) {
            CGRect frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 80);
            NSString *title = [menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            
        }else if(i<8){
            CGRect frame = CGRectMake((i-4)*screen_width/4, 80, screen_width/4, 80);
            NSString *title = [menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
        }else if(i < 12){
            CGRect frame = CGRectMake((i-8)*screen_width/4, 0, screen_width/4, 80);
            NSString *title = [menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView2 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
        }else{
            CGRect frame = CGRectMake((i-12)*screen_width/4, 80, screen_width/4, 80);
            NSString *title = [menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView2 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
        }
    }
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screen_width/2-20, 160, 0, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 2;
    [self addSubview:_pageControl];
    [_pageControl setCurrentPageIndicatorTintColor:navigationBarColor];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
}


-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}

@end

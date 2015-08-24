//
//  HomeMenuCell.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMenuCell : UITableViewCell<UIScrollViewDelegate>{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray;

@end

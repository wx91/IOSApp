//
//  CustomCalloutView.m
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CustomCalloutView.h"

@implementation CustomCalloutView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapCalloutView)];
    [self addGestureRecognizer:tap];
    //图
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kImageWidth, kImageHeight)];
    _imageView.backgroundColor=[UIColor blackColor];
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin*2+kImageWidth, kPortraitMargin, kTitleWidth, kTitleHeight)];
    _titleLabel.font=[UIFont boldSystemFontOfSize:14];
    _titleLabel.textColor=[UIColor whiteColor];
    _titleLabel.text=@"Title";
    [self addSubview:_titleLabel];
    
    _subtitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kPortraitMargin * 2 + kImageWidth, kPortraitMargin * 2 + kTitleHeight, kTitleWidth, kTitleHeight)];
    _subtitleLabel.font=[UIFont systemFontOfSize:12];
    _subtitleLabel.textColor=[UIColor lightGrayColor];
    _subtitleLabel.text=@"subtitle";
    [self addSubview:_subtitleLabel];
}
-(void)setTitle:(NSString *)title{
    _title=title;
    _titleLabel.text=title;
}
-(void)setSubtitle:(NSString *)subtitle{
    _subtitle=subtitle;
    _subtitleLabel.text=subtitle;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
}
-(void)drawRect:(CGRect)rect{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}
-(void)drawInContext:(CGContextRef)context{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}
-(void)getDrawPath:(CGContextRef)context{
    
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    //画向下的三角形
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context, midx, maxy+kArrorHeight);//画直线
    CGContextAddLineToPoint(context, midx-kArrorHeight, maxy);
    
    //画4个圆弧
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);//画完后 current point不在minx,miny，而是在圆弧结束的地方
    CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}
-(void)OnTapCalloutView{
    NSLog(@"title:%@",_title);
}

@end

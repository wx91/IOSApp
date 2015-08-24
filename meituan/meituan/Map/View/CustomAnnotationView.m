//
//  CustomAnnotationView.m
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "UIImageView+WebCache.h"

@implementation CustomAnnotationView

-(void)setJzAnnotation:(JZMAAroundAnnotation *)jzAnnotation{
    _jzAnnotation = jzAnnotation;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected==selected) {
        return ;
    }
    if (selected) {
        if (self.calloutView==nil) {
            self.calloutView=[[CustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center=CGPointMake(CGRectGetWidth(self.bounds)/2.f+self.calloutOffset.x, -CGRectGetHeight(self.calloutView.bounds)/2.f+self.calloutOffset.y);
        }
        NSString *imgUrl = [_jzAnnotation.jzmaaroundM.imgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"104.63"];
        [self.calloutView.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
         [self addSubview:self.calloutView];

    }else{
        [self.calloutView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}
//重写此函数,⽤用以实现点击calloutView判断为点击该annotationView
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL inside = [super pointInside:point withEvent:event];
    if (!inside && self.selected) {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    return inside;
}
@end

//
//  WeiboAnnotationView.h
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView{
    UIImageView *userImage;     //用户头像
    UIImageView *weiboImage;    //微博图片视图
    UILabel *textLabel;         //微博内容
}

@end

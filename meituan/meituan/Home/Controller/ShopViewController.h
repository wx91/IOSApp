//
//  ShopViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopInfoModel.h"

@interface ShopViewController : UITableViewController{
    UILabel *_titleLabel;
    UIActivityIndicatorView *_activityView;
    NSString *_recommendTitle;
    NSMutableArray *_shopRecommendArray;
    //数据源
    ShopInfoModel *_shopInfoM;
    
}

@property(nonatomic, strong) NSString *shopID;


@end

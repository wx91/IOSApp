//
//  JZMerchantViewController.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMerchantFilterView.h"


@interface JZMerchantViewController : UIViewController<UIGestureRecognizerDelegate,JZMerchantFilterDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_MerchantArray;
    NSString *_locationInfoStr;
    NSInteger _KindID;//分类查询,默认-1
    NSInteger _offset;
    UIView *_maskView;
    JZMerchantFilterView *_groupView;
}
@property(nonatomic, strong) UITableView *tableView;


@end

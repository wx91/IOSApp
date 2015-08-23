//
//  JZMerchantFilterView.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZMerchantFilterDelegate <NSObject>

@optional

//点击tableview，过滤id
-(void)tableview:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
          withId:(NSNumber *)ID withName:(NSString *)name;
@end

@interface JZMerchantFilterView : UIView<UITableViewDataSource,UITableViewDelegate>{
    //左边分组tableview的数据源
    NSMutableArray *_bigGroupArray;
    //右边分组tableview的数据源
    NSMutableArray *_smallGroupArray;
    
    NSInteger _bigSelectedIndex;
    
    NSInteger _smallSelectedIndex;
}

@property(nonatomic,strong)UITableView *tableViewOfGroup;

@property(nonatomic,strong)UITableView *tableViewOfDetail;

@property(nonatomic,assign)id<JZMerchantFilterDelegate> delegate;;


@end

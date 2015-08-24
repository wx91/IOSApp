//
//  JZMenuCellDelegate.h
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KWHC_MENUCELL_ANMATION_PADING (10.0)

@class JZMenuCell;
@protocol JZMenuCellDelegate <NSObject>

@optional
-(BOOL)JZMenuCell:(JZMenuCell *)menuCell didPullCell:(NSInteger)index;

@end


@interface JZMenuCell : UITableViewCell<UIGestureRecognizerDelegate>{
    BOOL                  _isOpen;
    BOOL                  _isScrollClose;
    CGFloat               _startX;
    UIView                *_menuView;
    UIPanGestureRecognizer  *_panGesture;
}

@property(nonatomic, assign) CGFloat menuViewWidth;
@property(nonatomic, strong) NSArray *menuItemTitles;
@property(nonatomic, strong) NSArray *menuItemTitleColors;
@property(nonatomic, strong) NSArray *menuItemBackImages;
@property(nonatomic, strong) NSArray *menuItemNormalImages;
@property(nonatomic, strong) NSArray *menuItemSelectedImages;
@property(nonatomic, strong) NSArray *menuItemBackColors;
@property(nonatomic, strong) NSArray *menuItemWidths;
@property(nonatomic, strong) UIView  *ContentView;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic ,assign) NSInteger index;       //cell下标

@property(nonatomic, assign) id<JZMenuCellDelegate> delegate;

//单击菜单项
-(void)clickMenuItem:(UIButton *)sender;

//关闭菜单

-(BOOL)closeCellWithAnimation:(BOOL)b;

//批量关闭菜单

- (BOOL)closeCellWithTableView:(UITableView*)tableView index:(NSInteger)index animation:(BOOL)b;

// 开始或者正在拉开菜单
- (void)startScrollviewCell:(BOOL)state x:(CGFloat)moveX;

//结束拉开菜单

- (void)didEndScrollViewCell:(BOOL)state;
@end

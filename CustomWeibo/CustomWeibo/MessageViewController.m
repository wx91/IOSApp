//
//  MessageViewController.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "MessageViewController.h"
#import "Constant.h"
#import "Status.h"
#import "MJExtension.h"
#import "UIThemeFactory.h"

@implementation MessageViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"消息";
        [self initView];
    }
    return self;
}

-(void)initView{
    tableView = [[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    tableView.eventDelegate = self;
    [self.view addSubview:tableView];
    NSArray *messageButton=@[@"navigationbar_mentions.png",@"navigationbar_comments.png",@"navigationbar_messages.png",@"navigationbar_notice.png"];
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    for (int i =0; i < messageButton.count; i++) {
        NSString *imageName = [messageButton objectAtIndex:i];
        UIButton *button=[UIThemeFactory createButton:imageName highligted:imageName selected:nil];
        button.showsTouchWhenHighlighted = YES;
        button.frame = CGRectMake(50*i + 20, 10, 22, 22);
        [button addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+2010;
        [titleView addSubview:button];
    }
    self.navigationItem.titleView = titleView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)messageAction:(UIButton *)button {
    if (button.tag == 2010) {
        NSLog(@"2010");
    }else if (button.tag == 2011){
        
    }else if (button.tag == 2012){
        
    }else if (button.tag == 2013){
        
    }
}


-(void)loadAtWeiboData{
    [super showHUD:@"卖力加载中...." isDim:NO];
    [WBHttpRequest requestWithURL:WB_AtMe httpMethod:@"GET" params:nil delegate:self withTag:@"WB_AtMe"];
}

#pragma mark  -WBHttpDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *weiboDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *WeiboInfo = [weiboDIC objectForKey:@"statuses"];
    
    NSMutableArray *weibos = [ NSMutableArray arrayWithCapacity:WeiboInfo.count];
    for (NSDictionary *statuesDic in WeiboInfo) {
        Status *weibo=[Status objectWithKeyValues:statuesDic];
        [weibos addObject:weibo];
    }
    [super.hud hide:YES afterDelay:0];
    tableView.hidden = NO;
    tableView.data = weibos;
    [tableView reloadData];
}

#pragma mark - UITableViewEventDegelate
- (void)pullDown:(BaseTableView *)tableView{
    
}
//上拉
- (void)pullUp:(BaseTableView *)tableView{
    
}
//选中cell
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

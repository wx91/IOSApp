//
//  ShopImageCell.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ShopImageCell.h"
#import "Constant.h"

@implementation ShopImageCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图
        self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 190)];
        [self.shopImageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
        [self.contentView addSubview:self.shopImageView];
        //店名
        self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.shopImageView.frame.size.height-30-30, screen_width-10, 30)];
        self.shopNameLabel.textColor = [UIColor whiteColor];
        //self.shopNameLabel.text = @"必胜客";
        [self.contentView addSubview:self.shopNameLabel];
        
        //标题
        self.shopTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.shopImageView.frame.size.height-30, screen_width-10, 30)];
        self.shopTitleLabel.textColor = [UIColor whiteColor];
        self.shopTitleLabel.font = [UIFont systemFontOfSize:13];
        //self.shopTitleLabel.text = @"100元心意美食卡1张，可叠加，免预约";
        [self.contentView addSubview:self.shopTitleLabel];
        
    }
    return self;
}
@end

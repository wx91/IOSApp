//
//  RecommendCell.m
//  meituan
//
//  Created by wangx on 15/8/22.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "RecommendCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "NSString+Size.h"

@implementation RecommendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _type = @"none";
        [self initViews];
    }
    return self;
}

-(void)initViews{
    //图
    self.shopImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    self.shopImage.layer.masksToBounds = YES;
    self.shopImage.layer.cornerRadius = 4.0;
    [self.contentView addSubview:self.shopImage];
    //免预约
    UIImageView *yuyueImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [yuyueImgV setImage:[UIImage imageNamed:@"ic_deal_noBooking"]];
    [self.contentView addSubview:yuyueImgV];
    
    //店名
    self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, screen_width-100-80, 30)];
    [self.contentView addSubview:self.shopNameLabel];
    
    //介绍
    self.shopInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, screen_width-100-10, 45)];
    self.shopInfoLabel.textColor = [UIColor lightGrayColor];
    self.shopInfoLabel.font = [UIFont systemFontOfSize:13];
    self.shopInfoLabel.numberOfLines = 2;
    [self.contentView addSubview:self.shopInfoLabel];
    
    //价格
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
    self.priceLabel.textColor = navigationBarColor;
    [self.contentView addSubview:self.priceLabel];
    
}
-(void)setRecommendData:(RecommendModel *)recommendData{
    _type = @"recommend";
    _recommendData = recommendData;
    NSString *imageUrl = [_recommendData.squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    self.shopNameLabel.text = recommendData.mname;
    self.shopInfoLabel.text = [NSString stringWithFormat:@"[%@]%@",recommendData.range,recommendData.title];
    NSString *priceStr = [NSString stringWithFormat:@"%d元",[recommendData.price intValue]];
    NSLog(@"%@",priceStr);
//    CGSize labelSize = [priceStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize labelSize = [priceStr boundingRectWithSize:CGSizeMake(200, 20) withFont:17];
    self.priceLabel.text = priceStr;
    self.priceLabel.frame = CGRectMake(100, 75, labelSize.width+10, 20);
}
-(void)setDealData:(DisDealModel *)dealData{
    _type = @"discount";
    _dealData = dealData;
    NSString *imageUrl = [dealData.squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    self.shopNameLabel.text = dealData.mname;
    self.shopInfoLabel.text = [NSString stringWithFormat:@"[%@]%@",dealData.range,dealData.title];
    
//    CGSize labelSize = [priceStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByWordWrapping];
    NSString *priceStr = [NSString stringWithFormat:@"%d元",[dealData.price intValue]];
    CGSize labelSize = [priceStr boundingRectWithSize:CGSizeMake(200, 20) withFont:17];
    self.priceLabel.text = priceStr;
    self.priceLabel.frame = CGRectMake(100, 75, labelSize.width+10, 20);
    
}

@end

//
//  JZKindFilterCell.m
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "JZKindFilterCell.h"
#import "Constant.h"
#import "NSString+Size.h"

@implementation JZKindFilterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=frame;
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        _numberBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _numberBtn.frame=CGRectMake(self.frame.size.width-85, 12, 80, 15);
        _numberBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        _numberBtn.layer.cornerRadius=7;
        _numberBtn.layer.masksToBounds=YES;
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateNormal];
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_numberBtn];
        
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        lineView.backgroundColor = RGB(192, 192, 192);
        [self.contentView addSubview:lineView];
        
        
    }
    return self;
}
-(void)setGroupM:(JZMerCateGroupModel *)groupM{
    _groupM=groupM;
    _nameLabel.text=groupM.name;
    if (groupM.list==nil) {
        [_numberBtn setTitle:[NSString stringWithFormat:@"%@",groupM.count] forState:UIControlStateNormal];
    }else{
        [_numberBtn setTitle:[NSString stringWithFormat:@"%@>",groupM.count] forState:UIControlStateNormal];
    }
    NSString *str = [NSString stringWithFormat:@"%@>",groupM.count];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
//    NSRange allRange=[text rangeOfString:text];
//    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:allRange];
//    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:allRange];
//    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//    CGSize textSize=[attrStr boundingRectWithSize:CGSizeMake(80.0f, CGFLOAT_MAX) options:options context:nil];
//    CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(80, 15) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(80, 15) withFont:11];
     _numberBtn.frame = CGRectMake(self.frame.size.width-10-textSize.width-10, 12, textSize.width+10, 15);
}

@end

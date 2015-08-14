//
//  FriendTableViewCell.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "UserGridView.h"
#import "User.h"

@implementation FriendTableViewCell

- (void)awakeFromNib {
    
}
-(void)setData:(NSArray *)data{
    if(_data!=data){
        _data=data;
    }
    
    for (int i=0; i<3; i++) {
        int  tag=2010+i;
        UserGridView *userGridView=(UserGridView *)[self.contentView viewWithTag:tag];
        userGridView.hidden=YES;
    }
}

-(void)layoutSubviews{
    [self layoutSubviews];
    for (int i=0; i<self.data.count; i++) {
        User *userModel=[self.data objectAtIndex:i];
        int tag=2010+i;
        UserGridView *gridView=(UserGridView *)[self.contentView viewWithTag:tag];
        
        gridView.userModel=userModel;
        gridView.hidden=NO;
        
        //让GridView异步调用layoutSubviews
        [gridView setNeedsLayout];
    }
    
}


@end

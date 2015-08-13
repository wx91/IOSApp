//
//  EmotionView.h
//  CustomWeibo
//
//  Created by wangx on 15/8/13.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBlock)(NSString *emotionName);
@interface EmotionView : UIView{
    NSMutableArray *items;
    UIImageView *magnifierView;
}
@property(nonatomic,copy)NSString *selectedEmotion;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,copy)SelectBlock block;

@end

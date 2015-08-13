//
//  SendViewController.h
//  CustomWeibo
//
//  Created by wangx on 15/8/12.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "BaseViewController.h"
#import "EmotionScrollView.h"

@interface SendViewController : BaseViewController<WBHttpRequestDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>{
    NSMutableArray *buttons;
    UIImageView *fullImageView;
    EmotionScrollView *emotionScrollView;
}

@property (nonatomic,copy)NSString * longitude;
@property (nonatomic,copy)NSString * latitude;

@property (nonatomic,retain)UIImage  *sendImage;

@property (nonatomic,retain)UIButton *sendImageButton;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIView *editBar;

@property (strong, nonatomic) IBOutlet UIView *placeView;

@property (strong, nonatomic) IBOutlet UIImageView *placeImageView;

@property (strong, nonatomic) IBOutlet UILabel *placeLabel;


@end

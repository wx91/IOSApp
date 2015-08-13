//
//  SendViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/12.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeButton.h"
#import "UIThemeFactory.h"
#import "UIViewExt.h"
#import "UIUtils.h"
#import "Constant.h"
#import "NearByViewController.h"
#import "BaseNavigationViewController.h"

@interface SendViewController ()

@end

@implementation SendViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //显示键盘
    [_textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    buttons=[[NSMutableArray alloc]initWithCapacity:6];
    UIButton *button=[UIThemeFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(cancelAction)];
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=cancelButton;
    
    UIButton *sendbutton=[UIThemeFactory createNavigationButton:CGRectMake(0, 0, 45, 30) title:@"发布" target:self action:@selector(sendAction)];
    UIBarButtonItem *sendItem=[[UIBarButtonItem alloc]initWithCustomView:sendbutton];
    self.navigationItem.rightBarButtonItem=sendItem;
    
    
}

-(void)initView{
    self.textView.delegate=self;
    UIImage *image=[self.placeImageView.image stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    [self.placeImageView setImage:image];
    self.placeLabel.left=35;
    self.placeLabel.width=120;
    NSArray *imageNames = [NSArray arrayWithObjects:
                             @"compose_locatebutton_background.png",
                             @"compose_camerabutton_background.png",
                             @"compose_trendbutton_background.png",
                             @"compose_mentionbutton_background.png",
                             @"compose_emoticonbutton_background.png",
                             @"compose_keyboardbutton_background.png",
                             nil];
    NSArray *imageHighted = [NSArray arrayWithObjects:
                             @"compose_locatebutton_background_highlighted.png",
                             @"compose_camerabutton_background_highlighted.png",
                             @"compose_trendbutton_background_highlighted.png",
                             @"compose_mentionbutton_background_highlighted.png",
                             @"compose_emoticonbutton_background_highlighted.png",
                             @"compose_keyboardbutton_background_highlighted.png",
                             nil];
    
        for (int i = 0; i < 6; i++) {
            NSString *imageName=[imageNames objectAtIndex:i];
            NSString *hightedName=[imageHighted objectAtIndex:i];
            UIButton *button=[UIThemeFactory createButton:imageName highligted:hightedName];
            [button setImage:[UIImage imageNamed:hightedName] forState:UIControlStateHighlighted];
            button.tag = (10+i);
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.frame=CGRectMake(20+(64*i), 25, 29, 19);
            [self.editBar addSubview:button];
            [buttons addObject:button];
            if (i==5) {
                button.hidden=YES;
                button.left-=64;
            }
        }
}
#pragma mark actions
-(void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)sendAction{
    [self doSendData];
    [self performSelector:@selector(cancelAction) withObject:nil afterDelay:1.0];
}
-(void)buttonAction:(UIButton *)button{
    if (button.tag==10) {
        //地理位置
        [self location];
    }else if (button.tag==11){
        //图片
        [self selectImage];
    }else if (button.tag==12){
        
    }else if (button.tag==13){
        
    }else if (button.tag==14){
        //表情
        [self showEmotionView];
    }else if(button.tag==15){
        //键盘
        [self showKeyboardView];
    }
}

#pragma mark-地理位置
-(void)location{
    NearByViewController *nearCtrl=[[NearByViewController alloc]init];
    BaseNavigationViewController *nearNav=[[BaseNavigationViewController alloc]initWithRootViewController:nearCtrl];
    [self presentViewController:nearNav animated:YES completion:nil];
    //实现block的方法
    nearCtrl.selectBlock=^(NSDictionary *result){
        NSLog(@"%@",result);
        self.longitude=[result objectForKey:@"long"];
        self.latitude=[result objectForKey:@"lat"];
        
        NSString *address=[result objectForKey:@"address"];
        if ([address isKindOfClass:[NSNull class]]||address.length == 0) {
            address=[result objectForKey:@"title"];
        }
        self.placeLabel.text=address;
        self.placeLabel.textAlignment=NSTextAlignmentCenter;
        self.placeView.hidden=NO;
        
        UIButton *locationButton=(UIButton *)[self.editBar viewWithTag:10];
        locationButton.selected=YES;
    };
}

#pragma mark 使用相册
-(void)selectImage{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
    [actionSheet showInView:self.view];
}
#pragma mark-UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerControllerSourceType soureType;
    if (buttonIndex==0) {
        BOOL isCameraDeviceAvailable=[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCameraDeviceAvailable) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        //拍照
        soureType=UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex==1){
        //用户相册
        soureType=UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (buttonIndex==2){
        return ;
    }
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=soureType;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark-UIImagePickerControllerDelegate
//这个方法是选择一张相片之后调用或者拍了一张照片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.sendImage=image;
    
    if (self.sendImageButton==nil) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius=5;
        button.layer.masksToBounds=YES;
        button.frame=CGRectMake(8, (self.editBar.height-25)/2, 25, 25);
        [button addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sendImageButton=button;
    }
    [self.sendImageButton setImage:image forState:UIControlStateNormal];
    [self.editBar addSubview:self.sendImageButton];
    UIButton *button1=(UIButton *)[self.editBar viewWithTag:10];
    UIButton *button2=(UIButton *)[self.editBar viewWithTag:11];
    [UIView animateWithDuration:0.5 animations:^{
        button1.transform=CGAffineTransformTranslate(button1.transform, 20, 0);
        button2.transform=CGAffineTransformTranslate(button2.transform, 20, 0);
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//选择图片
-(void)imageAction:(UIButton *)button{
    if (fullImageView==nil) {
        fullImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        fullImageView.backgroundColor=[UIColor clearColor];
        fullImageView.userInteractionEnabled=YES;
        fullImageView.contentMode=UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        [fullImageView addGestureRecognizer:tap];
        
        //创建删除按钮
        UIButton *deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"trash.png"]forState:UIControlStateNormal];
        deleteButton.frame=CGRectMake(ScreenWidth-50, 10, 50,50);
        deleteButton.tag=100;
        [deleteButton  setShowsTouchWhenHighlighted:YES];
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.textView resignFirstResponder];
    if (![fullImageView superview]) {
        fullImageView.image=self.sendImage;
        [self.view.window addSubview:fullImageView];
        
        fullImageView.frame=CGRectMake(self.sendImageButton.left, self.editBar.top+self.editBar.height/2-self.sendImageButton.height/2, 25, 25);
        [UIView animateWithDuration:0.4 animations:^{
            fullImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden = YES;
            UIButton *deleteButton = (UIButton *)[fullImageView viewWithTag:100];
            deleteButton.hidden = NO;
        }];
    }
}
//根据手势放大缩小图片
-(void)scaleImageAction:(UITapGestureRecognizer *)tap{
    [fullImageView viewWithTag:100].hidden=YES;
    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIView animateWithDuration:0.4 animations:^{
        fullImageView.frame=CGRectMake(self.sendImageButton.left, self.editBar.top+self.editBar.height/2-self.sendImageButton.height/2, 25, 25);
    } completion:^(BOOL finished) {
        [fullImageView removeFromSuperview];
    }];
    [self.textView becomeFirstResponder];
}
//取消图片选择
-(void)deleteAction:(UIButton *)button{
    [self scaleImageAction:nil];
    button.hidden=YES;
    [self.sendImageButton removeFromSuperview];
    self.sendImage=nil;
    UIButton *button1 = (UIButton *)[self.editBar viewWithTag:10];
    UIButton *button2 = (UIButton *)[self.editBar viewWithTag:11];
    [UIView animateWithDuration:0.5 animations:^{
        //为什么用transform？因为可以快速恢复回去，非常方便
        button1.transform = CGAffineTransformIdentity;
        button2.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - 使用表情
-(void)showEmotionView{
    [_textView resignFirstResponder];
    if (emotionScrollView==nil) {
        __block SendViewController *this=self;
        emotionScrollView=[[EmotionScrollView alloc]initwithSelectBlock:^(NSString *emotionName) {
            NSString *text=this.textView.text;
            text=[text stringByAppendingString:emotionName];
            this.textView.text=text;
        }];
        emotionScrollView.bottom=ScreenHeight;
        emotionScrollView.transform=CGAffineTransformTranslate(emotionScrollView.transform, 0, ScreenHeight-self.editBar.bottom);
        [self.view addSubview:emotionScrollView];
    }
    
    UIButton *emotionButton=(UIButton *)[self.editBar viewWithTag:14];
    UIButton *keyboradButton=(UIButton *)[self.editBar viewWithTag:15];
    emotionButton.alpha=1;
    keyboradButton.alpha=0;
    keyboradButton.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.editBar.transform=CGAffineTransformTranslate(self.editBar.transform, 0, (ScreenHeight-self.editBar.bottom)-emotionScrollView.height);
        emotionScrollView.transform=CGAffineTransformIdentity;
        emotionButton.alpha=0;
        emotionButton.selected=NO;
        keyboradButton.alpha=1;
        emotionButton.hidden=YES;
    }];
}
#pragma mark 使用键盘
-(void)showKeyboardView{
    [_textView becomeFirstResponder];
    UIButton *emoitonButton=(UIButton *)[self.editBar viewWithTag:14];
    UIButton *keyboardButton=(UIButton *)[self.editBar viewWithTag:15];
    [UIView animateWithDuration:0.2 animations:^{
        emotionScrollView.transform = CGAffineTransformTranslate(emotionScrollView.transform, 0, ScreenHeight- self.editBar.bottom);
        self.editBar.transform = CGAffineTransformIdentity;
        emoitonButton.hidden     = NO;
        emoitonButton.alpha      = 1;
        keyboardButton.hidden    = YES;
    }];
}


#pragma mark -NSNotification
-(void)keyboardShowNotification:(NSNotification *)notification{
    NSValue *keyboradValue=[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame=[keyboradValue CGRectValue];
    CGFloat height=frame.size.height;
    self.editBar.bottom=ScreenHeight-height-20-44;
    self.textView.height=self.editBar.top;
}
#pragma mark weibo mehthod
//发送微博
-(void)doSendData{
    [super showStatusTip:YES title:@"发送中..."];
    NSString *weiboText=self.textView.text;
    if (weiboText.length==0) {
        NSLog(@"微博内容为空");
        return ;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:weiboText forKey:@"status"];
    if (self.longitude.length>0) {
        [params setObject:self.longitude forKey:@"long"];
    }
    if (self.latitude.length>0) {
        [params setObject:self.latitude forKey:@"lat"];
    }
    if (self.sendImage==nil) {
        //不带图的微博
        [WBHttpRequest requestWithURL:WB_postWeibo httpMethod:@"POST" params:params delegate:self withTag:@"postWeibo"];
    }else{
        //带图微博
        NSData *data=UIImageJPEGRepresentation(self.sendImage, 1);
        [params setObject:data forKey:@"pic"];
        [WBHttpRequest requestWithURL:WB_postWeiboWithPic httpMethod:@"POST" params:params delegate:self withTag:@"postWeiboWithPic"];
    }
    [super performSelector:@selector(multipleValue:) withObject:[NSArray arrayWithObjects:@"NO",@"发送成功",nil] afterDelay:1.5];
}




#pragma mark system method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

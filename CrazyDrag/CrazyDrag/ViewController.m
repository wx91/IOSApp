//
//  ViewController.m
//  CrazyDrag
//
//  Created by wangx on 15/3/27.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController (){
    int currentValue;
    int targetValue;
    int score;
    int round;
}


- (IBAction)sliderMoved:(id)sender;

- (IBAction)showAlert:(id)sender;
- (IBAction)startOver:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController
@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize audioPlayer;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted=[UIImage imageNamed:@"SliderThumb- Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    
    [self startNewGame];
    [self updateLabels];
    //[self playBackgroundMusic];
}

//-(void)playBackgroundMusic{
//    NSString *musicPath=[[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
//    NSURL *url=[NSURL fileURLWithPath:musicPath];
//    NSError *error;
//    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//    audioPlayer.numberOfLoops=-1;
//    if (audioPlayer==nil) {
//        NSString *errorInfo=[NSString stringWithFormat:[error description]];
//        NSLog(@"the error is :%@",errorInfo);
//    }else{
//        [audioPlayer play];
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
     
}
-(void)updateLabels{
    self.targetLabel.text=[NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",score];
    self.roundLabel.text=[NSString stringWithFormat:@"%d",round];
}
-(void)startNewRound{
    round+=1;
    targetValue=1+(arc4random()%100);
    currentValue=50;
    self.slider.value=currentValue;
}

- (IBAction)showAlert:(id)sender {
    int difference=abs(currentValue-targetValue);
    int points=100-difference;
    score+=points;
    NSString *title;
    if (difference==0) {
        title=@"土豪你太NB了！";
        points+=100;
    }else if(difference<10){
        title=@"好吧，勉强算个土豪";
        points+=50;
    }else if(difference<10){
        title=@"好吧，勉强算个土豪！";
    }else{
         title=@"不是土豪少来装！";
    }
    NSString *message=[NSString stringWithFormat:@"恭喜高富帅，你的得分是：%d",score];
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"朕以知晓，爱卿辛苦了" otherButtonTitles:nil, nil]show];
    [self startNewRound];
    [self updateLabels];

}
-(void)startNewGame{
    
    score=0;
    round=0;
    [self startNewRound];
}
- (IBAction)startOver:(id)sender {
    //添加过渡效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade; transition.duration = 3;
    transition.timingFunction = [CAMediaTimingFunction
                                 functionWithName:kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self updateLabels];
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)sliderMoved:(UISlider *)sender {
    currentValue=(int)lround(sender.value);
}
- (IBAction)showInfo:(id)sender {
    AboutViewController *controller=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

@end

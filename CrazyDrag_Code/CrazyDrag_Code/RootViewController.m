//
//  RootViewController.m
//  CrazyDrag_Code
//
//  Created by wangx on 15/6/15.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//

#import "RootViewController.h"
#import "AboutViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController{
    int currentValue;
    int targetValue;
    int score;
    int round;
}


-(void)loadView{
    UIView *view=[[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    self.view=view;
    
    //设置背景图片
    UIImageView *backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Background"]];
    [self.view addSubview:backgroundView];
    
    //设置描述label
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(100, 40, 280, 20)];
    label1.text=@"拖动滑动条让靶心尽可能接近数字：";
    label1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    //设置数字目标label
    _targetLabel=[[UILabel alloc]initWithFrame:CGRectMake(380, 40, 30, 20)];
    _targetLabel.text=@"100";
    [self.view addSubview:_targetLabel];
    
    //设置UISlider的最小值，UILabel
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(60, 90, 10, 30)];
    label2.text=@"1";
    [self.view addSubview:label2];
    
    //设置UISlider控件
    _slider=[[UISlider alloc]initWithFrame:CGRectMake(70, 90, 350, 30)];
    _slider.minimumValue=1;
    _slider.maximumValue=100;
    [self.slider addTarget:self action:@selector(sliderMoved:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_slider];
    
    //设置UISlider的最大值，UILabel
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(430, 90, 30, 30)];
    label3.text=@"100";
    [self.view addSubview:label3];
    
    //"打我呀" 按钮
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame=CGRectMake(230, 150, 50, 30);
    [button1 setTitle:@"打我呀" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    //"重新来过"按钮
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(40, 200, 60, 30);
    [button2 setTitle:@"重新来过" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(startOver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    //显示分数 label
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(120, 200, 60, 30)];
    label4.text=@"分数：";
    label4.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label4];
    
    _scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 200, 30, 30)];
    _scoreLabel.text=@"499";
    _scoreLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_scoreLabel];
    
    //显示回个数的label
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(250, 200, 70, 30)];
    label5.text=@"回合数：";
    label5.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label5];
    
    //计算总共会合数
    _roundLabel=[[UILabel alloc]initWithFrame:CGRectMake(350, 200, 30, 30)];
    _roundLabel.text=@"2";
    _roundLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_roundLabel];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeInfoLight];
    button3.frame=CGRectMake(400, 200, 22, 22);
    [button3 addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    UIImage *thumbImageHighlighted=[UIImage imageNamed:@"SliderThumb- Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabel];
    //[self playBackgroundMusic];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)playBackgroundMusic{
    NSString *musicPath=[[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url=[NSURL fileURLWithPath:musicPath];
    NSError *error;
    self.audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    self.audioPlayer.numberOfLoops=-1;
    if (self.audioPlayer==nil) {
        NSString *errorInfo=[NSString stringWithFormat:[error description]];
        NSLog(@"the error is :%@",errorInfo);
    }else{
        [self.audioPlayer play];
    }
}

//游戏数据清零重新开始
-(void)startNewGame{
    score=0;//分数
    round=0;//会合数
    [self startNewRound];
}
//开始新一轮的游戏
-(void)startNewRound{
    round+=1;
    targetValue=1+(arc4random()%100);
    currentValue=50;
    self.slider.value=currentValue;
}
//重新设置游戏的游戏
-(void)updateLabel{
    //设置目标描述的值
    self.targetLabel.text=[NSString stringWithFormat:@"%d",targetValue];
    //设置它的得分
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",score];
    //计算它的游戏的轮数
    self.roundLabel.text=[NSString stringWithFormat:@"%d",round];
}


-(void)sliderMoved:(UISlider *)slider{
    currentValue=(int)lround(slider.value);
}

-(void)showAlert{
    int diff=abs(currentValue-targetValue);
    int points=100-diff;
    score+=points;
    NSString *title;
    if (diff==0) {
        title=@"土豪你太NB了！";
        points+=100;
    }else if (diff<10){
        title=@"勉强算个土豪!";
        points+=50;
    }else{
        title=@"不是土豪少来转!";
    }
    NSString *message=[NSString stringWithFormat:@"恭喜高富帅，你拖到的分数是%d,你的得分是：%d",currentValue,score];
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"朕以知晓，爱卿辛苦了" otherButtonTitles:nil, nil] show];
    [self startNewRound];
    [self updateLabel];
    
}

-(void)startOver{
    //添加过渡效果
    CATransition *transition=[CATransition animation];
    transition.type=kCATransitionFade;
    transition.duration=1;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self updateLabel];
    [self.view.layer addAnimation:transition forKey:nil];
}

-(void)showInfo{
    AboutViewController *controller=[[AboutViewController alloc]init];
    controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

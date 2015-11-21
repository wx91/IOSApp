//
//  ViewController.swift
//  CrazyDraySwift
//
//  Created by 王享 on 15/11/21.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UIAlertViewDelegate{
    var score:Int!
    var round:Int!
    var currentValue:Int!
    var targetValue:Int!
    
    var slider:UISlider!
    var targetLabel:UILabel!
    var scoreLabel:UILabel!
    var roundLabel:UILabel!
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView();
        self.startNewGame()
        self.updateLabel()
    }
    
    func initView(){
        
        let backgroundView:UIImageView! = UIImageView.init(image: UIImage .init(named:"Background"));
        self.view.addSubview(backgroundView);
        
        //设置描述Label
        let label1:UILabel!=UILabel.init()
        label1.frame=CGRectMake(100, 40, 280, 20)
        label1.text="拖动滑动条让靶心尽可能接近数字："
        label1.textAlignment=NSTextAlignment.Center
        self.view.addSubview(label1)
        
        //设置数字目标Label
        targetLabel = UILabel.init()
        targetLabel.frame=CGRectMake(380, 40, 30, 20)
        targetLabel.text="100"
        self.view.addSubview(targetLabel)
        
        //设置UISlider的最小值
        let label2:UILabel! = UILabel.init()
        label2.frame=CGRectMake(60, 90, 10, 30)
        label2.text="1"
        self.view.addSubview(label2)
        
        //设置UISlider控件
        slider=UISlider.init()
        slider.frame=CGRectMake(70, 90, 350, 30)
        slider.minimumValue=1
        slider.maximumValue=100
        slider.addTarget(self, action: Selector.init("sliderMoved:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(slider)
        
        //设置UISlider的最大值
        let label3:UILabel! = UILabel.init()
        label3.frame=CGRectMake(430, 90, 30, 30)
        label3.text="100"
        self.view.addSubview(label3)
        
        //"打我呀"按钮
        let button1:UIButton! = UIButton.init(type: UIButtonType.RoundedRect)
        button1.frame=CGRectMake(230, 150, 50, 30)
        button1.titleLabel?.font=UIFont.systemFontOfSize(14)
        button1.setTitle("打我呀", forState: UIControlState.Normal)
        button1.addTarget(self, action: Selector.init("showAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(button1)
        
        //"重新来过"按钮
        let button2:UIButton! = UIButton.init(type: UIButtonType.RoundedRect)
        button2.frame=CGRectMake(40, 200, 60, 30)
        button2.setTitle("重新来过", forState: UIControlState.Normal)
        button2.titleLabel?.font=UIFont.systemFontOfSize(14)
        button2.addTarget(self, action: Selector.init("startOver"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2)
        
        //显示分数Label
        let label4:UILabel! = UILabel.init()
        label4.frame = CGRectMake(120, 200, 60, 30)
        label4.text="分数:"
        label4.textAlignment=NSTextAlignment.Center
        self.view.addSubview(label4)
        
        //显示分数的Label
        scoreLabel = UILabel.init()
        scoreLabel.frame=CGRectMake(200, 200, 50, 30)
        scoreLabel.text="499"
        scoreLabel.textAlignment=NSTextAlignment.Center
        self.view.addSubview(scoreLabel)
        
        //显示回合数的Label
        let label5:UILabel! = UILabel.init()
        label5.frame=CGRectMake(250, 200, 70, 30)
        label5.text="回合数"
        label5.textAlignment=NSTextAlignment.Center
        self.view.addSubview(label5)
        
        //计算总共回合数
        roundLabel = UILabel.init()
        roundLabel.frame=CGRectMake(350, 200, 30, 30)
        roundLabel.text="2"
        roundLabel.textAlignment=NSTextAlignment.Center
        self.view.addSubview(roundLabel)
        
        let button3:UIButton! = UIButton.init(type: UIButtonType.InfoLight)
        button3.frame=CGRectMake(400, 200, 22, 22)
        button3.addTarget(self, action: Selector.init("showInfo"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button3)
        
        let thumbImageNormal:UIImage? = UIImage.init(named:"SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: UIControlState.Normal)
        let thumbImageHighlighted:UIImage? = UIImage.init(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: UIControlState.Highlighted)
        let trackLeftImage:UIImage? = UIImage.init(named: "SliderTrackLeft")
        trackLeftImage!.stretchableImageWithLeftCapWidth(14, topCapHeight: 0)
        slider.setMinimumTrackImage(trackLeftImage, forState: UIControlState.Normal)
        let trackRightImage:UIImage? = UIImage.init(named: "SliderTrackRight")
        trackRightImage!.stretchableImageWithLeftCapWidth(14, topCapHeight: 0)
        slider.setMaximumTrackImage(trackRightImage, forState: UIControlState.Normal)
        
    }
    func playBackgroundMusic(){
//        let musicPath = NSBundle.mainBundle().pathForResource("no", ofType: "mp3")
//        let url:NSURL = NSURL.fileURLWithPath(musicPath!)
//        audioPlayer = AVAudioPlayer.init(contentsOfURL: url)
//        audioPlayer.numberOfLoops = -1
//        if audioPlayer == nil{
//            print("error")
//        }else{
//            audioPlayer.play()
//        }
    }
    
    //游戏数据清零重新开始
    func startNewGame(){
        score = 0 //分数
        round = 0 //回合数
        self.startNewRound()
    }
    
    func startNewRound(){
        round = round + 1;
        targetValue = 1+Int(arc4random()%100)
        arc4random_stir()
        currentValue=50
        slider.value = Float(currentValue)
    }
    
    func updateLabel(){
        //设置目标描述的值
        targetLabel.text="\(targetValue)"
        //设置它的得分
        scoreLabel.text="\(score)"
        //计算它的游戏的回合数
        roundLabel.text="\(round)"
    }
    func sliderMoved(slider:UISlider!){
        currentValue = lroundf(slider.value)
    }
    
    func showAlert(){
        let diff:Int! = (currentValue - targetValue)
        var points:Int! = 100 - diff
        score = score + points
        var title:String? = ""
        if(diff == 0){
            title = "土豪你太NB了！"
            points = points + 100
        }else if(diff < 10){
            title = "勉强算个土豪!"
            points = points + 50;
        }else{
            title = "不是土豪少来转!"
        }
        var message:String?="恭喜高富帅，你拖到的分数是:\(currentValue),你的得分是：\(score)"
        let alertView:UIAlertView? =  UIAlertView.init(title: title!, message: message!, delegate: self, cancelButtonTitle: "朕以知晓，爱卿辛苦了", otherButtonTitles:"确定")
        alertView?.show()
        self.startNewRound()
        self.updateLabel()
    }
    
    func startOver(){
        let transition:CATransition!=CATransition.init()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction =
            CAMediaTimingFunction.init(name:kCAMediaTimingFunctionEaseOut)
        
        self.startNewRound()
        self .updateLabel()
        self.view.layer .addAnimation(transition, forKey: nil)
    }
    func showInfo(){
        let controller:AboutViewController! = AboutViewController.init()
        self .presentViewController(controller, animated: true, completion: nil)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}



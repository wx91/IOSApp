//
//  AboutViewController.swift
//  CrazyDraySwift
//
//  Created by 王享 on 15/11/21.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView(){
        let backgroundView:UIImageView! = UIImageView.init()
        backgroundView.frame = UIScreen.mainScreen().bounds
        backgroundView.image=UIImage.init(named: "Background")
        self.view .addSubview(backgroundView)
        
        let tv:UITextView! = UITextView.init()
        tv.frame =  CGRectMake(0, 0, 480, 200)
        tv.text = "欢迎加⼊入⼟土豪俱乐部!修炼⼟土豪真⾦金的⽅方式很简单,你只需要拖动界⾯面中的滑动条就好了。!你的⽬目标是让滑动条的结点尽可能接近预设的分数,越接近表⽰示你的⼟土豪成分越⾼高。欢迎 获取真⾦金!"
        self.view .addSubview(tv)
        
        let button:UIButton! = UIButton.init(type: UIButtonType.RoundedRect)
        button.frame=CGRectMake(0, 250, 480, 50)
        button.backgroundColor = UIColor.yellowColor()
        button.setTitle("关闭当前页面", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector.init("close"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    func close(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

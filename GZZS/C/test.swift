//
//  test.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/19.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class test: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 50, width: WIDTH, height: 64))
        label.text = "传送门"
        label.textColor = COLOR_BLACK
        label.textAlignment = .center
        label.font = UIFont.init(name: ".PingFangSC-Light", size: 25.0)
        self.view.addSubview(label)
        self.homeView()
    }
    
    func homeView(){
        let a = UIButton.init(frame: CGRect.init(x: WIDTH*0.375, y: 150, width: WIDTH/4, height: WIDTH/4))
        a.setTitle("PRD", for: .normal)
        a.backgroundColor = COLOR_RED_V2
        a.setTitleColor(COLOR_WHITE, for: .normal)
        a.layer.cornerRadius = WIDTH/8.0
        a.titleLabel?.font = UIFont.init(name: ".PingFangSC-Light", size: 20.0)
        a.addTarget(self, action: #selector(jumpa), for: .touchDown)
        self.view.addSubview(a)
        
        let b = UIButton.init(frame: CGRect.init(x: WIDTH/8, y: a.frame.maxY + (((WIDTH*0.625 + WIDTH / 8 - WIDTH / 4)/2)*1.732)-WIDTH/4, width: WIDTH/4, height: WIDTH/4))
        b.setTitle("PRE", for: .normal)
        b.backgroundColor = COLOR_GREEN
        b.setTitleColor(COLOR_WHITE, for: .normal)
        b.layer.cornerRadius = WIDTH/8.0
        b.titleLabel?.font = UIFont.init(name: ".PingFangSC-Light", size: 20.0)
        b.addTarget(self, action: #selector(jumpb), for: .touchDown)
        self.view.addSubview(b)
        
        let c = UIButton.init(frame: CGRect.init(x: WIDTH*0.625, y: b.frame.minY, width: WIDTH/4, height: WIDTH/4))
        c.setTitle("TEST", for: .normal)
        c.backgroundColor = COLOR_BLUE
        c.setTitleColor(COLOR_WHITE, for: .normal)
        c.layer.cornerRadius = WIDTH/8.0
        c.titleLabel?.font = UIFont.init(name: ".PingFangSC-Light", size: 20.0)
        c.addTarget(self, action: #selector(jumpc), for: .touchDown)
        self.view.addSubview(c)
        
        let d = UIButton.init(frame: CGRect.init(x: WIDTH*0.375, y: c.frame.maxY + (((WIDTH * 0.625 + WIDTH / 8 - WIDTH / 4)/2)*1.732) - WIDTH / 4, width: WIDTH/4, height: WIDTH/4))
        d.setTitle("返回", for: .normal)
        d.backgroundColor = COLOR_BACKGROUND
        d.setTitleColor(COLOR_WHITE, for: .normal)
        d.layer.cornerRadius = WIDTH/8.0
        d.titleLabel?.font = UIFont.init(name: ".PingFangSC-Light", size: 20.0)
        d.addTarget(self, action: #selector(jumpd), for: .touchDown)
        self.view.addSubview(d)
    }
    
    func jumpa(){
        UserDefaults.standard.set("PrdApi", forKey: "host")
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.appOut), userInfo: nil, repeats: false)
    }
    
    func jumpb(){
        UserDefaults.standard.set("PreApi", forKey: "host")
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.appOut), userInfo: nil, repeats: false)
    }
    
    func jumpc(){
        UserDefaults.standard.set("TestApi", forKey: "host")
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.appOut), userInfo: nil, repeats: false)
    }
    
    func jumpd(){
        dismiss(animated: true, completion: {() -> Void in
            //关掉注册controller
        })
    }
    
    func appOut(){
        exit(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

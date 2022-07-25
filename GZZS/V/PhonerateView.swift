//
//  PhonerateView.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/7.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//交话费

import UIKit

class PhonerateView: UIView {

    var phoneNumberTextfield = UITextField()
    var homeLocationLabel = UILabel()
    var contactButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let homeView = UIView.init(frame: frame)
        homeView.backgroundColor = COLOR_WHITE
        self.addSubview(homeView)
        homeView.addSubview(mobileView())

    }
    
    func mobileView() -> UIView {
        let mobileView = UIView.init(frame: CGRect(x:0,y:0,width:WIDTH,height:136))
        mobileView.backgroundColor = COLOR_WHITE
        
        phoneNumberTextfield.frame = CGRect(x:10,y:15,width:WIDTH-50,height:50)
        phoneNumberTextfield.font = UIFont.systemFont(ofSize: 30.0)
        phoneNumberTextfield.textColor = UIColor.black
        phoneNumberTextfield.keyboardType = .numberPad
        phoneNumberTextfield.placeholder = "请输入手机号"
        phoneNumberTextfield.clearButtonMode = .always
        mobileView.addSubview(phoneNumberTextfield)
        
        contactButton.frame = CGRect(x:WIDTH - 40.0,y:25,width:30,height:30)
        contactButton .setImage(UIImage.init(named: "contact.png"), for:.normal )
        mobileView.addSubview(contactButton)
        
        //归属地
        homeLocationLabel.frame = CGRect(x:phoneNumberTextfield.frame.minX,y:phoneNumberTextfield.frame.maxY,width:WIDTH-75,height:20)
        homeLocationLabel.font = UIFont.systemFont(ofSize: 15.0)
        homeLocationLabel.textColor = COLOR_GREY
        mobileView.addSubview(homeLocationLabel)
        
        let line = UILabel.init(frame: CGRect(x:10,y:homeLocationLabel.frame.maxY + 5 ,width:WIDTH - 20,height:1))
        line.backgroundColor = COLOR_LINE_GRAY
        mobileView.addSubview(line)
        
        let label = UILabel.init(frame: CGRect(x:10,y:line.frame.maxY + 5,width:160,height:30))
        label.text = "选择支付金额"
        label.textColor = COLOR_GREY
        label.font = UIFont.systemFont(ofSize: 15.0)
        mobileView.addSubview(label)
        
        return mobileView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

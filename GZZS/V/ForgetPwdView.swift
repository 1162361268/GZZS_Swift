//
//  ForgetPwdView.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/11.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class ForgetPwdView: UIView {
    
    var nameView = UIView()
    var idView = UIView()
    var phoneView = UIView()
    
    var nameTF = UITextField()
    var idTF = UITextField()
    var phoneLabel = UILabel()
    var veryCodeTF = UITextField()

    override init(frame:CGRect) {
        super.init(frame: frame)
        self.homeNameView()
        self.homeIdView()
        self.homePhoneView()
        self.homeVeryCodeView()
    }
    
    func homeNameView() {
        nameView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: 60))
        nameView.backgroundColor = COLOR_WHITE
        self.addSubview(nameView)
        
        let nameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        nameLabel.text = "姓名："
        nameLabel.textColor = COLOR_TEXT_GREY
        nameLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        nameLabel.sizeToFit()
        nameLabel.center = CGPoint.init(x: nameLabel.frame.width / 2 + 10, y: 30)
        nameView.addSubview(nameLabel)
        
        nameTF = UITextField.init(frame: CGRect.init(x: nameLabel.frame.maxX, y: 0, width: WIDTH-nameLabel.frame.maxX, height: 60))
        nameTF.placeholder = "输入姓名"
        nameTF.textColor = COLOR_TEXT_GREY
        nameTF.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        nameTF.keyboardType = .default
        nameTF.clearButtonMode = .whileEditing
        nameView.addSubview(nameTF)
    }
    
    func homeIdView() {
        idView = UIView.init(frame: CGRect.init(x: 0, y: nameView.frame.maxY + 1, width: WIDTH, height: 60))
        idView.backgroundColor = COLOR_WHITE
        self.addSubview(idView)
        
        let idLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        idLabel.text = "身份证号："
        idLabel.textColor = COLOR_TEXT_GREY
        idLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        idLabel.sizeToFit()
        idLabel.center = CGPoint.init(x: idLabel.frame.width / 2 + 10, y: 30)
        idView.addSubview(idLabel)
        
        idTF = UITextField.init(frame: CGRect.init(x: idLabel.frame.maxX, y: 0, width: WIDTH-idLabel.frame.maxX, height: 60))
        idTF.placeholder = "输入身份证号码"
        idTF.textColor = COLOR_TEXT_GREY
        idTF.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        idTF.keyboardType = .default
        idTF.clearButtonMode = .whileEditing
        idView.addSubview(idTF)
    }
    
    func homePhoneView() {
        phoneView = UIView.init(frame: CGRect.init(x: 0, y: idView.frame.maxY + 1, width: WIDTH, height: 60))
        phoneView.backgroundColor = COLOR_WHITE
        self.addSubview(phoneView)
        
        phoneLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: WIDTH, height: 60))
        phoneLabel.text = "手机号"
        phoneLabel.textColor = COLOR_TEXT_GREY
        phoneLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 15.0)
        phoneView.addSubview(phoneLabel)
    }
    
    func homeVeryCodeView() {
        let veryCodeView = UIView.init(frame: CGRect.init(x: 0, y: phoneView.frame.maxY + 1, width: WIDTH, height: 60))
        veryCodeView.backgroundColor = COLOR_WHITE
        self.addSubview(veryCodeView)
        
        let veryCodeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        veryCodeLabel.text = "验证码："
        veryCodeLabel.textColor = COLOR_TEXT_GREY
        veryCodeLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        veryCodeLabel.sizeToFit()
        veryCodeLabel.center = CGPoint.init(x: veryCodeLabel.frame.width / 2 + 10, y: 30)
        veryCodeView.addSubview(veryCodeLabel)
        
        veryCodeTF = UITextField.init(frame: CGRect.init(x: veryCodeLabel.frame.maxX, y: 0, width: WIDTH-veryCodeLabel.frame.maxX, height: 60))
        veryCodeTF.placeholder = "输入收到的验证码"
        veryCodeTF.textColor = COLOR_TEXT_GREY
        veryCodeTF.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        veryCodeTF.keyboardType = .numberPad
        veryCodeTF.clearButtonMode = .whileEditing
        veryCodeView.addSubview(veryCodeTF)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

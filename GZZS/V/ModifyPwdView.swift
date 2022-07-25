//
//  ModifyPwdView.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/11.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class ModifyPwdView: UIView {

    var oldPasswordView = UIView()
    var newPasswordView = UIView()
    var againPasswordView = UIView()

    var oldPasswordTF = UITextField()
    var newPasswordTF = UITextField()
    var againPasswordTF = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        oldPassword()
        newPassword()
        againPassword()
        
    }
    
    func oldPassword() {
        oldPasswordView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: 60))
        oldPasswordView.backgroundColor = COLOR_WHITE
        self.addSubview(oldPasswordView)
        
        let oldPasswordLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 100, height: 60))
        oldPasswordLabel.text = "原支付密码："
        oldPasswordLabel.textColor = COLOR_TEXT_GREY
        oldPasswordLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 15.0)
        oldPasswordLabel.sizeToFit()
        oldPasswordLabel.center = CGPoint.init(x: oldPasswordLabel.frame.width / 2 + 10, y: 30)
        oldPasswordView.addSubview(oldPasswordLabel)
        
        oldPasswordTF = UITextField.init(frame: CGRect.init(x: oldPasswordLabel.frame.maxX, y: 0, width: WIDTH - oldPasswordLabel.frame.maxX, height: 60))
        oldPasswordTF.placeholder = "输入原支付密码"
        oldPasswordTF.textColor = COLOR_GREY
        oldPasswordTF.font = UIFont.systemFont(ofSize: 15.0)
        oldPasswordTF.keyboardType = .numberPad
        oldPasswordTF.clearButtonMode = .whileEditing
        oldPasswordTF.isSecureTextEntry = true
        oldPasswordView.addSubview(oldPasswordTF)
    }
    
    func newPassword() {
        newPasswordView = UIView.init(frame: CGRect.init(x: 0, y: oldPasswordView.frame.maxY + 1, width: WIDTH, height: 60))
        newPasswordView.backgroundColor = COLOR_WHITE
        self.addSubview(newPasswordView)
        
        let newPasswordLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 100, height: 60))
        newPasswordLabel.text = "新支付密码："
        newPasswordLabel.textColor = COLOR_TEXT_GREY
        newPasswordLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 15.0)
        newPasswordLabel.sizeToFit()
        newPasswordLabel.center = CGPoint.init(x: newPasswordLabel.frame.width / 2 + 10, y: 30)
        newPasswordView.addSubview(newPasswordLabel)
        
        newPasswordTF = UITextField.init(frame: CGRect.init(x: newPasswordLabel.frame.maxX, y: 0, width: WIDTH - newPasswordLabel.frame.maxX, height: 60))
        newPasswordTF.placeholder = "输入新支付密码"
        newPasswordTF.textColor = COLOR_GREY
        newPasswordTF.font = UIFont.systemFont(ofSize: 15.0)
        newPasswordTF.keyboardType = .numberPad
        newPasswordTF.clearButtonMode = .whileEditing
        newPasswordTF.isSecureTextEntry = true
        newPasswordView.addSubview(newPasswordTF)
    }
    
    func againPassword() {
        againPasswordView = UIView.init(frame: CGRect.init(x: 0, y:newPasswordView.frame.maxY + 1, width: WIDTH, height: 60))
        againPasswordView.backgroundColor = COLOR_WHITE
        self.addSubview(againPasswordView)
        
        let againPasswordLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 100, height: 60))
        againPasswordLabel.text = "确认新支付密码："
        againPasswordLabel.textColor = COLOR_TEXT_GREY
        againPasswordLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 15.0)
        againPasswordLabel.sizeToFit()
        againPasswordLabel.center = CGPoint.init(x: againPasswordLabel.frame.width / 2 + 10, y: 30)
        againPasswordView.addSubview(againPasswordLabel)
        
        againPasswordTF = UITextField.init(frame: CGRect.init(x: againPasswordLabel.frame.maxX, y: 0, width: WIDTH - againPasswordLabel.frame.maxX, height: 60))
        againPasswordTF.placeholder = "输入新支付密码"
        againPasswordTF.textColor = COLOR_GREY
        againPasswordTF.font = UIFont.systemFont(ofSize: 15.0)
        againPasswordTF.keyboardType = .numberPad
        againPasswordTF.clearButtonMode = .whileEditing
        againPasswordTF.isSecureTextEntry = true
        againPasswordView.addSubview(againPasswordTF)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

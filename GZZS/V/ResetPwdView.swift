//
//  ResetPwdView.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/13.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class ResetPwdView: UIView {

    var payView = UIView()
    var pwdTF = UITextField()
    var confirmPwdTF = UITextField()

    override init(frame:CGRect) {
        super.init(frame: frame)
        
        self.homePayView()
        self.homeConfirmPwdView()
    }
    
    func homePayView() {
        
        payView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: 60))
        payView.backgroundColor = COLOR_WHITE
        self.addSubview(payView)
        
        let pwdLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        pwdLabel.text = "支付密码："
        pwdLabel.textColor = COLOR_TEXT_GREY
        pwdLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        pwdLabel.sizeToFit()
        pwdLabel.center = CGPoint.init(x: pwdLabel.frame.width / 2 + 10, y: 30)
        payView.addSubview(pwdLabel)
        
        pwdTF = UITextField.init(frame: CGRect.init(x: pwdLabel.frame.maxX, y: 0, width: WIDTH-pwdLabel.frame.maxX, height: 60))
        pwdTF.placeholder = "输入支付密码"
        pwdTF.isSecureTextEntry = true
        pwdTF.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        pwdTF.textColor = COLOR_TEXT_GREY
        pwdTF.keyboardType = .numberPad
        pwdTF.clearButtonMode = .whileEditing
        payView.addSubview(pwdTF)
    }
    
    func homeConfirmPwdView() {
        let confirmPwdView = UIView.init(frame: CGRect.init(x: 0, y: payView.frame.maxY+1, width: WIDTH, height: 60))
        confirmPwdView.backgroundColor = COLOR_WHITE
        self.addSubview(confirmPwdView)
        
        let confirmLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        confirmLabel.text = "确认支付密码"
        confirmLabel.textColor = COLOR_TEXT_GREY
        confirmLabel.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        confirmLabel.center = CGPoint.init(x: confirmLabel.frame.width / 2 + 10, y: 30)
        confirmPwdView.addSubview(confirmLabel)
        
        confirmPwdTF = UITextField.init(frame: CGRect.init(x: confirmLabel.frame.maxX, y: 0, width: WIDTH-confirmLabel.frame.maxX, height: 60))
        confirmPwdTF.placeholder = "再次输入支付密码"
        confirmPwdTF.font = UIFont.init(name: ".PingFangSC-Regular", size: 16.0)
        confirmPwdTF.isSecureTextEntry = true
        confirmPwdTF.textColor = COLOR_TEXT_GREY
        confirmPwdTF.keyboardType = .numberPad
        confirmPwdTF.clearButtonMode = .whileEditing
        confirmPwdView.addSubview(confirmPwdTF)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

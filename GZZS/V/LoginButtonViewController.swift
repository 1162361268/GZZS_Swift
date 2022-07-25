//
//  LoginButton.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/9/1.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

class LoginButtonViewController: UIView {
    var loginButton = UIButton()
    
    func loginButton(str:String,frame:CGRect) {
        loginButton.frame = frame
        loginButton.layer.cornerRadius = 5.0
        loginButton.setTitle(str, for:.normal )
        loginButton.backgroundColor = COLOR_RED_V2
        self.addSubview(loginButton)
    }
}

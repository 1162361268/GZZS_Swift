//
//  TCCountDown.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/9/4.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

class TCCountDown :UIView {

    private var countdownTimer: Timer?
    var codeBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        codeBtn.frame = frame
        codeBtn.layer.masksToBounds = true
        codeBtn.layer.cornerRadius = 10/2.0
        codeBtn.setTitle("获取验证码", for: .normal)
        codeBtn.setTitleColor(COLOR_RED_V2, for:UIControlState.normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9.0)
        codeBtn.layer.borderWidth = 1.0
        codeBtn.layer.borderColor = COLOR_RED_V2.cgColor
        self.addSubview(codeBtn)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var remainingSeconds: Int = 0 {
        willSet {
            
            codeBtn.layer.masksToBounds = true
            codeBtn.layer.cornerRadius = 10/2.0
            codeBtn.setTitleColor(COLOR_RED_V2, for: UIControlState.normal)
            codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9.0)
            codeBtn.layer.borderWidth = 1.0
            codeBtn.layer.borderColor = COLOR_RED_V2.cgColor

            codeBtn.setTitle("重新获取\(newValue)秒", for: .normal)
            
            if newValue <= 0 {
                codeBtn.setTitle("获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                codeBtn.setTitleColor(COLOR_RED_V2, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                codeBtn.setTitleColor(COLOR_RED_V2, for: .normal)
            }
            
            codeBtn.isEnabled = !newValue
        }
    }
    @objc private func updateTime() {
        remainingSeconds -= 1
    }

}



//
//  ElectricityView.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/5.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//交电费

import UIKit

class ElectricityView: UIView {
    
    var publicParamNameField = UITextField()
    var payAmountLabel = UILabel()
    var amountField = UITextField()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let homeView = UIView.init(frame: frame)

        homeView.backgroundColor = COLOR_BACKGROUND
        self.addSubview(homeView)
        homeView.addSubview(self.oneView())
        homeView.addSubview(self.twoView())
        homeView.addSubview(self.threeView())
        homeView.addSubview(adText())

    }
    
    func oneView() -> UIView {
        let oneView = UIView.init(frame: CGRect(x:0,y:0,width:WIDTH,height:70))
        oneView.backgroundColor = COLOR_WHITE
        
        let label = UILabel.init(frame: CGRect(x:20,y:0,width:WIDTH - 40,height:70))
        label.text = "缴费单位:   云南电网有限责任公司"
        label.textColor = COLOR_GREY
        label.backgroundColor = COLOR_WHITE
        label.font = UIFont.systemFont(ofSize: 16.0)
        oneView.addSubview(label)
        
        return oneView
    }
    
    func twoView() -> UIView {
        let twoView = UIView.init(frame: CGRect(x:0,y:71,width:WIDTH,height:90))
        twoView.backgroundColor = COLOR_WHITE
        
        let publicParamTextLabel = UILabel.init(frame: CGRect(x:20,y:0,width:90,height:45))
        publicParamTextLabel.text = "客户编号"
        publicParamTextLabel.textColor = COLOR_GREY
        publicParamTextLabel.font = UIFont.systemFont(ofSize: 16.0)
        twoView.addSubview(publicParamTextLabel)
        
        publicParamNameField.frame = CGRect(x:90,y:0,width:WIDTH-100,height:45)
        publicParamNameField.textColor = COLOR_GREY
        publicParamNameField.font = UIFont.systemFont(ofSize: 16.0)
        publicParamNameField.clearButtonMode = .always
        publicParamNameField.keyboardType = .numberPad
        publicParamNameField.placeholder = "请输入电费单号"
        twoView.addSubview(publicParamNameField)
        
        payAmountLabel.frame = CGRect(x:20,y:45,width:WIDTH-100,height:45)
        payAmountLabel.textColor = COLOR_GREY
        payAmountLabel.font = UIFont.systemFont(ofSize: 15.0)
        twoView.addSubview(payAmountLabel)
        
        return twoView
    }
    
    func threeView() -> UIView {
        let threeView = UIView.init(frame: CGRect(x:0,y:71 + 91,width:WIDTH,height:70))
        threeView.backgroundColor = COLOR_WHITE
        
        let publicParamTextLabel = UILabel.init(frame: CGRect(x:20,y:0,width:90,height:70))
        publicParamTextLabel.text = "缴费金额"
        publicParamTextLabel.textColor = COLOR_GREY
        publicParamTextLabel.font = UIFont.systemFont(ofSize: 16.0)
        threeView.addSubview(publicParamTextLabel)
        
        amountField.frame = CGRect(x:90,y:0,width:WIDTH-100,height:70)
        amountField.textColor = COLOR_GREY
        amountField.font = UIFont.systemFont(ofSize: 16.0)
        amountField.clearButtonMode = .always
        amountField.keyboardType = .decimalPad
        amountField.placeholder = "请输入缴费金额"
        threeView.addSubview(amountField)
        
        return threeView
    }
    
    func adText() -> UILabel {
        let adText = UILabel.init(frame: CGRect(x:10,y:400,width:WIDTH-20,height:70))
        adText.text = "*支付成功后请在交易记录查看缴费结果"
        adText.textColor = COLOR_GREY
        adText.font = UIFont.systemFont(ofSize: 11.0)
        
        return adText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 }

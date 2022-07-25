//
//  PayPasswordView.swift
//  GZZS
//
//  Created by LiuHao on 2017/10/26.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class PayPasswordView: UIView,UITextFieldDelegate {

    var label_title = UILabel()
    var textField = UITextField()
    var confirmTextField = UITextField()
    var tilteView = UIView()
    var closeBtn = UIButton()
    var label1Button = UIButton()
    var label2Button = UIButton()
    var orderPriceLabel = UILabel()
    var orderPrice = UILabel()
    var orderCarNumberLabel = UILabel()
    var orderCarNumber = UILabel()
    
    var view_box  = UIView()
    var view_box2 = UIView()
    var view_box3 = UIView()
    var view_box4 = UIView()
    var view_box5 = UIView()
    var view_box6 = UIView()

    var view_box_1 = UIView()
    var view_box_2 = UIView()
    var view_box_3 = UIView()
    var view_box_4 = UIView()
    var view_box_5 = UIView()
    var view_box_6 = UIView()

    var label_point  = UILabel()
    var label_point2 = UILabel()
    var label_point3 = UILabel()
    var label_point4 = UILabel()
    var label_point5 = UILabel()
    var label_point6 = UILabel()
    var label_box1 = UILabel()
    
    var label_point_1 = UILabel()
    var label_point_2 = UILabel()
    var label_point_3 = UILabel()
    var label_point_4 = UILabel()
    var label_point_5 = UILabel()
    var label_point_6 = UILabel()
    var label_box2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.textField.delegate = self
        self.textField.keyboardType = .numberPad
        self.textField.tag = 0
        self.textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for:.editingChanged )
        self.addSubview(self.textField)
        
        self.confirmTextField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.confirmTextField.delegate = self
        self.confirmTextField.keyboardType = .numberPad
        self.tag = 1
        self.confirmTextField.addTarget(self, action: #selector(textFieldDidChange2(sender:)), for: .editingChanged)
        self.addSubview(self.confirmTextField)
        
        let label = UILabel.init(frame: CGRect.init(x: 35, y: 80, width: 200, height: 30))
        label.text = "设置6位支付密码"
        label.textColor = COLOR_GREY
        label.font = UIFont.systemFont(ofSize: 15.0)
        self.addSubview(label)
        
        self.view_box = UIView.init(frame: CGRect.init(x: 35, y: label.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box.backgroundColor = COLOR_WHITE
        self.view_box.layer.borderWidth = 1.0
        self.view_box.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box)
        
        self.view_box2 = UIView.init(frame: CGRect.init(x: 35 + boxWidth , y: self.view_box.frame.origin.y, width: boxWidth, height: boxWidth))
        self.view_box2.backgroundColor = COLOR_WHITE
        self.view_box2.layer.borderWidth = 1.0
        self.view_box2.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box2)
        
        self.view_box3 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 2, y: self.view_box.frame.origin.y, width: boxWidth, height: boxWidth))
        self.view_box3.backgroundColor = COLOR_WHITE
        self.view_box3.layer.borderWidth = 1.0
        self.view_box3.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box3)
        
        self.view_box4 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 3, y: self.view_box.frame.origin.y, width: boxWidth, height: boxWidth))
        self.view_box4.backgroundColor = COLOR_WHITE
        self.view_box4.layer.borderWidth = 1.0
        self.view_box4.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box4)
        
        self.view_box5 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 4, y: self.view_box.frame.origin.y, width: boxWidth, height: boxWidth))
        self.view_box5.backgroundColor = COLOR_WHITE
        self.view_box5.layer.borderWidth = 1.0
        self.view_box5.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box5)
        
        self.view_box6 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 5, y: self.view_box.frame.origin.y, width: boxWidth, height: boxWidth))
        self.view_box6.backgroundColor = COLOR_WHITE
        self.view_box6.layer.borderWidth = 1.0
        self.view_box6.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box6)
        
        self.label_box1 = UILabel.init(frame: CGRect.init(x: self.view_box.frame.minX, y: self.view_box.frame.minY, width: boxWidth * 6, height: boxWidth))
        self.label_box1.layer.borderWidth = 1.0
        self.label_box1.layer.borderColor = COLOR_RED_V2.cgColor
        self.addSubview(self.label_box1)
        
        let label2 = UILabel.init(frame: CGRect.init(x: 35, y: self.view_box.frame.maxY + 10, width: 200, height: 30))
        label2.text = "确认支付密码"
        label2.textColor = COLOR_GREY
        label2.font = UIFont.systemFont(ofSize: 15.0)
        self.addSubview(label2)
        
        self.view_box_1 = UIView.init(frame: CGRect.init(x: 35, y: label2.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box_1.backgroundColor = COLOR_WHITE
        self.view_box_1.layer.borderWidth = 1.0
        self.view_box_1.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box_1)
        
        self.view_box_2 = UIView.init(frame: CGRect.init(x: 35 + boxWidth, y: label2.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box_2.backgroundColor = COLOR_WHITE
        self.view_box_2.layer.borderWidth = 1.0
        self.view_box_2.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box_2)
        
        self.view_box_3 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 2, y: label2.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box_3.backgroundColor = COLOR_WHITE
        self.view_box_3.layer.borderWidth = 1.0
        self.view_box_3.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box_3)
        
        self.view_box_4 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 3, y: label2.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box_4.backgroundColor = COLOR_WHITE
        self.view_box_4.layer.borderWidth = 1.0
        self.view_box_4.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box_4)
        
        self.view_box_5 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 4, y: label2.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box_5.backgroundColor = COLOR_WHITE
        self.view_box_5.layer.borderWidth = 1.0
        self.view_box_5.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box_5)
        
        self.view_box_6 = UIView.init(frame: CGRect.init(x: 35 + boxWidth * 5, y: label2.frame.maxY + 10, width: boxWidth, height: boxWidth))
        self.view_box_6.backgroundColor = COLOR_WHITE
        self.view_box_6.layer.borderWidth = 1.0
        self.view_box_6.layer.borderColor = COLOR_LINE.cgColor
        self.addSubview(self.view_box_6)
        
        self.label_box2 = UILabel.init(frame: CGRect.init(x: self.view_box_1.frame.minX, y: self.view_box_1.frame.minY, width: boxWidth * 6, height: boxWidth))
        self.label_box2.layer.borderWidth = 1.0
        self.label_box2.layer.borderColor = COLOR_RED_V2.cgColor
        self.label_box2.isHidden = true
        self.addSubview(self.label_box2)
        
        self.label_point = UILabel.init(frame: CGRect.init(x: (self.view_box.frame.size.width - 10)/2, y: (self.view_box.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point.layer.cornerRadius = 5
        self.label_point.layer.masksToBounds = true
        self.label_point.backgroundColor = COLOR_RED_V2
        self.view_box.addSubview(self.label_point)
        
        self.label_point2 = UILabel.init(frame: CGRect.init(x: (self.view_box.frame.size.width - 10)/2, y: (self.view_box.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point2.layer.cornerRadius = 5
        self.label_point2.layer.masksToBounds = true
        self.label_point2.backgroundColor = COLOR_RED_V2
        self.view_box2.addSubview(self.label_point2)
        
        self.label_point3 = UILabel.init(frame: CGRect.init(x: (self.view_box.frame.size.width - 10)/2, y: (self.view_box.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point3.layer.cornerRadius = 5
        self.label_point3.layer.masksToBounds = true
        self.label_point3.backgroundColor = COLOR_RED_V2
        self.view_box3.addSubview(self.label_point3)
        
        self.label_point4 = UILabel.init(frame: CGRect.init(x: (self.view_box.frame.size.width - 10)/2, y: (self.view_box.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point4.layer.cornerRadius = 5
        self.label_point4.layer.masksToBounds = true
        self.label_point4.backgroundColor = COLOR_RED_V2
        self.view_box4.addSubview(self.label_point4)
        
        self.label_point5 = UILabel.init(frame: CGRect.init(x: (self.view_box.frame.size.width - 10)/2, y: (self.view_box.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point5.layer.cornerRadius = 5
        self.label_point5.layer.masksToBounds = true
        self.label_point5.backgroundColor = COLOR_RED_V2
        self.view_box5.addSubview(self.label_point5)
        
        self.label_point6 = UILabel.init(frame: CGRect.init(x: (self.view_box.frame.size.width - 10)/2, y: (self.view_box.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point6.layer.cornerRadius = 5
        self.label_point6.layer.masksToBounds = true
        self.label_point6.backgroundColor = COLOR_RED_V2
        self.view_box6.addSubview(self.label_point6)
        
        self.label_point_1 = UILabel.init(frame: CGRect.init(x: (self.view_box_1.frame.size.width - 10)/2, y: (self.view_box_1.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point_1.layer.cornerRadius = 5
        self.label_point_1.layer.masksToBounds = true
        self.label_point_1.backgroundColor = COLOR_RED_V2
        self.view_box_1.addSubview(self.label_point_1)
        
        self.label_point_2 = UILabel.init(frame: CGRect.init(x: (self.view_box_1.frame.size.width - 10)/2, y: (self.view_box_1.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point_2.layer.cornerRadius = 5
        self.label_point_2.layer.masksToBounds = true
        self.label_point_2.backgroundColor = COLOR_RED_V2
        self.view_box_2.addSubview(self.label_point_2)
        
        self.label_point_3 = UILabel.init(frame: CGRect.init(x: (self.view_box_1.frame.size.width - 10)/2, y: (self.view_box_1.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point_3.layer.cornerRadius = 5
        self.label_point_3.layer.masksToBounds = true
        self.label_point_3.backgroundColor = COLOR_RED_V2
        self.view_box_3.addSubview(self.label_point_3)
        
        self.label_point_4 = UILabel.init(frame: CGRect.init(x: (self.view_box_1.frame.size.width - 10)/2, y: (self.view_box_1.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point_4.layer.cornerRadius = 5
        self.label_point_4.layer.masksToBounds = true
        self.label_point_4.backgroundColor = COLOR_RED_V2
        self.view_box_4.addSubview(self.label_point_4)
        
        self.label_point_5 = UILabel.init(frame: CGRect.init(x: (self.view_box_1.frame.size.width - 10)/2, y: (self.view_box_1.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point_5.layer.cornerRadius = 5
        self.label_point_5.layer.masksToBounds = true
        self.label_point_5.backgroundColor = COLOR_RED_V2
        self.view_box_5.addSubview(self.label_point_5)
        
        self.label_point_6 = UILabel.init(frame: CGRect.init(x: (self.view_box_1.frame.size.width - 10)/2, y: (self.view_box_1.frame.size.width - 10)/2, width: 10, height: 10))
        self.label_point_6.layer.cornerRadius = 5
        self.label_point_6.layer.masksToBounds = true
        self.label_point_6.backgroundColor = COLOR_RED_V2
        self.view_box_6.addSubview(self.label_point_6)
        
        self.label_point.isHidden = true
        self.label_point2.isHidden = true
        self.label_point3.isHidden = true
        self.label_point4.isHidden = true
        self.label_point5.isHidden = true
        self.label_point6.isHidden = true
        
        self.label_point_1.isHidden = true
        self.label_point_2.isHidden = true
        self.label_point_3.isHidden = true
        self.label_point_4.isHidden = true
        self.label_point_5.isHidden = true
        self.label_point_6.isHidden = true
        
        self.label1Button = UIButton.init(frame: CGRect.init(x: 0, y: self.view_box.frame.minY, width: WIDTH, height: boxWidth))
        self.label1Button.backgroundColor = UIColor.clear
        self.label1Button.addTarget(self, action: #selector(touchLabel1), for: .touchUpInside)
        self.addSubview(self.label1Button)
        
        self.label2Button = UIButton.init(frame: CGRect.init(x: 0, y: self.view_box_1.frame.minY, width: WIDTH, height: boxWidth))
        self.label2Button.backgroundColor = UIColor.clear
        self.label2Button.addTarget(self, action: #selector(touchLabel2), for: .touchUpInside)
        self.addSubview(self.label2Button)
        
        self.backgroundColor = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
    }
    
    func cleanTrace(){
        self.label_point.isHidden = true
        self.label_point2.isHidden = true
        self.label_point3.isHidden = true
        self.label_point4.isHidden = true
        self.label_point5.isHidden = true
        self.label_point6.isHidden = true
        
        self.isHidden = true
        self.textField.text = ""
    }
    
    func touchLabel1(){
        self.label_box1.isHidden = false
        self.label_box2.isHidden = true
        self.textField.becomeFirstResponder()
    }
    
    func touchLabel2(){
        self.label_box1.isHidden = true
        self.label_box2.isHidden = false
        self.confirmTextField.becomeFirstResponder()
    }
    
    func textFieldDidChange(sender: AnyObject?){
        let _field :UITextField = sender as! UITextField
        self.label_box1.isHidden = false
        self.label_box2.isHidden = true
        switch (_field.text?.count) {
        case 0?:
            do {
            self.label_point.isHidden = true
            self.label_point2.isHidden = true
            self.label_point3.isHidden = true
            self.label_point4.isHidden = true
            self.label_point5.isHidden = true
            self.label_point6.isHidden = true
            
            self.view_box.backgroundColor = COLOR_WHITE
            self.view_box2.backgroundColor = COLOR_WHITE
            self.view_box3.backgroundColor = COLOR_WHITE
            self.view_box4.backgroundColor = COLOR_WHITE
            self.view_box5.backgroundColor = COLOR_WHITE
            self.view_box6.backgroundColor = COLOR_WHITE

        }
            break
            
        case 1?:
        do{
            self.label_point.isHidden = false
            self.label_point2.isHidden = true
            self.label_point3.isHidden = true
            self.label_point4.isHidden = true
            self.label_point5.isHidden = true
            self.label_point6.isHidden = true
            
            self.view_box.backgroundColor = COLOR_WHITE
            self.view_box2.backgroundColor = COLOR_BACKGROUND
            self.view_box3.backgroundColor = COLOR_WHITE
            self.view_box4.backgroundColor = COLOR_WHITE
            self.view_box5.backgroundColor = COLOR_WHITE
            self.view_box6.backgroundColor = COLOR_WHITE
        }
            break
        case 2?:
            do{
                self.label_point.isHidden = false
                self.label_point2.isHidden = false
                self.label_point3.isHidden = true
                self.label_point4.isHidden = true
                self.label_point5.isHidden = true
                self.label_point6.isHidden = true
                
                self.view_box.backgroundColor = COLOR_WHITE
                self.view_box2.backgroundColor = COLOR_WHITE
                self.view_box3.backgroundColor = COLOR_BACKGROUND
                self.view_box4.backgroundColor = COLOR_WHITE
                self.view_box5.backgroundColor = COLOR_WHITE
                self.view_box6.backgroundColor = COLOR_WHITE
            }
            break
        case 3?:
            do{
                self.label_point.isHidden = false
                self.label_point2.isHidden = false
                self.label_point3.isHidden = false
                self.label_point4.isHidden = true
                self.label_point5.isHidden = true
                self.label_point6.isHidden = true
                
                self.view_box.backgroundColor = COLOR_WHITE
                self.view_box2.backgroundColor = COLOR_WHITE
                self.view_box3.backgroundColor = COLOR_WHITE
                self.view_box4.backgroundColor = COLOR_BACKGROUND
                self.view_box5.backgroundColor = COLOR_WHITE
                self.view_box6.backgroundColor = COLOR_WHITE
            }
            break
        case 4?:
            do{
                self.label_point.isHidden = false
                self.label_point2.isHidden = false
                self.label_point3.isHidden = false
                self.label_point4.isHidden = false
                self.label_point5.isHidden = true
                self.label_point6.isHidden = true
                
                self.view_box.backgroundColor = COLOR_WHITE
                self.view_box2.backgroundColor = COLOR_WHITE
                self.view_box3.backgroundColor = COLOR_WHITE
                self.view_box4.backgroundColor = COLOR_WHITE
                self.view_box5.backgroundColor = COLOR_BACKGROUND
                self.view_box6.backgroundColor = COLOR_WHITE
            }
            break
        case 5?:
            do{
                self.label_point.isHidden = false
                self.label_point2.isHidden = false
                self.label_point3.isHidden = false
                self.label_point4.isHidden = false
                self.label_point5.isHidden = false
                self.label_point6.isHidden = true
                
                self.view_box.backgroundColor = COLOR_WHITE
                self.view_box2.backgroundColor = COLOR_WHITE
                self.view_box3.backgroundColor = COLOR_WHITE
                self.view_box4.backgroundColor = COLOR_WHITE
                self.view_box5.backgroundColor = COLOR_WHITE
                self.view_box6.backgroundColor = COLOR_BACKGROUND
            }
            break
        case 6?:
            do{
                self.label_point.isHidden = false
                self.label_point2.isHidden = false
                self.label_point3.isHidden = false
                self.label_point4.isHidden = false
                self.label_point5.isHidden = false
                self.label_point6.isHidden = false
                
                self.view_box.backgroundColor = COLOR_WHITE
                self.view_box2.backgroundColor = COLOR_WHITE
                self.view_box3.backgroundColor = COLOR_WHITE
                self.view_box4.backgroundColor = COLOR_WHITE
                self.view_box5.backgroundColor = COLOR_WHITE
                self.view_box6.backgroundColor = COLOR_WHITE
            }
            break
            
        default:
            break
        }
        
        if (_field.text?.count == 6){
            self .touchLabel2()
        }
        
    }
    func textFieldDidChange2(sender: AnyObject?){
        let _field :UITextField = sender as! UITextField
        self.label_box1.isHidden = true
        self.label_box2.isHidden = false
        switch (_field.text?.count) {
        case 0?:
        do{
            self.label_point_1.isHidden = true
            self.label_point_2.isHidden = true
            self.label_point_3.isHidden = true
            self.label_point_4.isHidden = true
            self.label_point_5.isHidden = true
            self.label_point_6.isHidden = true
            
            self.view_box_1.backgroundColor = COLOR_WHITE
            self.view_box_2.backgroundColor = COLOR_WHITE
            self.view_box_3.backgroundColor = COLOR_WHITE
            self.view_box_4.backgroundColor = COLOR_WHITE
            self.view_box_5.backgroundColor = COLOR_WHITE
            self.view_box_6.backgroundColor = COLOR_WHITE
        }
            break
        case 1?:
            do{
                self.label_point_1.isHidden = false
                self.label_point_2.isHidden = true
                self.label_point_3.isHidden = true
                self.label_point_4.isHidden = true
                self.label_point_5.isHidden = true
                self.label_point_6.isHidden = true
                
                self.view_box_1.backgroundColor = COLOR_WHITE
                self.view_box_2.backgroundColor = COLOR_BACKGROUND
                self.view_box_3.backgroundColor = COLOR_WHITE
                self.view_box_4.backgroundColor = COLOR_WHITE
                self.view_box_5.backgroundColor = COLOR_WHITE
                self.view_box_6.backgroundColor = COLOR_WHITE
            }
            break
        case 2?:
            do{
                self.label_point_1.isHidden = false
                self.label_point_2.isHidden = false
                self.label_point_3.isHidden = true
                self.label_point_4.isHidden = true
                self.label_point_5.isHidden = true
                self.label_point_6.isHidden = true
                
                self.view_box_1.backgroundColor = COLOR_WHITE
                self.view_box_2.backgroundColor = COLOR_WHITE
                self.view_box_3.backgroundColor = COLOR_BACKGROUND
                self.view_box_4.backgroundColor = COLOR_WHITE
                self.view_box_5.backgroundColor = COLOR_WHITE
                self.view_box_6.backgroundColor = COLOR_WHITE
            }
            break
        case 3?:
            do{
                self.label_point_1.isHidden = false
                self.label_point_2.isHidden = false
                self.label_point_3.isHidden = false
                self.label_point_4.isHidden = true
                self.label_point_5.isHidden = true
                self.label_point_6.isHidden = true
                
                self.view_box_1.backgroundColor = COLOR_WHITE
                self.view_box_2.backgroundColor = COLOR_WHITE
                self.view_box_3.backgroundColor = COLOR_WHITE
                self.view_box_4.backgroundColor = COLOR_BACKGROUND
                self.view_box_5.backgroundColor = COLOR_WHITE
                self.view_box_6.backgroundColor = COLOR_WHITE
            }
            break
        case 4?:
            do{
                self.label_point_1.isHidden = false
                self.label_point_2.isHidden = false
                self.label_point_3.isHidden = false
                self.label_point_4.isHidden = false
                self.label_point_5.isHidden = true
                self.label_point_6.isHidden = true
                
                self.view_box_1.backgroundColor = COLOR_WHITE
                self.view_box_2.backgroundColor = COLOR_WHITE
                self.view_box_3.backgroundColor = COLOR_WHITE
                self.view_box_4.backgroundColor = COLOR_WHITE
                self.view_box_5.backgroundColor = COLOR_BACKGROUND
                self.view_box_6.backgroundColor = COLOR_WHITE
            }
            break
        case 5?:
            do{
                self.label_point_1.isHidden = false
                self.label_point_2.isHidden = false
                self.label_point_3.isHidden = false
                self.label_point_4.isHidden = false
                self.label_point_5.isHidden = false
                self.label_point_6.isHidden = true
                
                self.view_box_1.backgroundColor = COLOR_WHITE
                self.view_box_2.backgroundColor = COLOR_WHITE
                self.view_box_3.backgroundColor = COLOR_WHITE
                self.view_box_4.backgroundColor = COLOR_WHITE
                self.view_box_5.backgroundColor = COLOR_WHITE
                self.view_box_6.backgroundColor = COLOR_BACKGROUND
            }
            break
        case 6?:
            do{
                self.label_point_1.isHidden = false
                self.label_point_2.isHidden = false
                self.label_point_3.isHidden = false
                self.label_point_4.isHidden = false
                self.label_point_5.isHidden = false
                self.label_point_6.isHidden = false
                
                self.view_box_1.backgroundColor = COLOR_WHITE
                self.view_box_2.backgroundColor = COLOR_WHITE
                self.view_box_3.backgroundColor = COLOR_WHITE
                self.view_box_4.backgroundColor = COLOR_WHITE
                self.view_box_5.backgroundColor = COLOR_WHITE
                self.view_box_6.backgroundColor = COLOR_WHITE
            }
            break
            
        default:
            break
        }
        if (_field.text?.count == 6){
            let vc = PayPasswordVC()
            vc.PayPassword(view: self, Password: _field.text!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existedLength: Int = (textField.text?.characters.count)!
        let selectedLength: Int = range.length
        let replaceLength: Int = (string.characters.count)
        
        if textField.tag == 0 {
            if (string.count == 0) {
                return true
            }
            if (existedLength - selectedLength + replaceLength > 6){
                self.touchLabel2()
                return false
            }
        }else if textField.tag == 1 {
            if (string.count == 0) {
                return true
            }
            if (existedLength - selectedLength + replaceLength > 6){
                return false
            }
            if (existedLength - selectedLength + replaceLength == 6){
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.viewTapped), userInfo: nil, repeats: false)

            }
        }
        return true
    }
    
    func viewTapped() {
        self.textField.resignFirstResponder()
        self.confirmTextField.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

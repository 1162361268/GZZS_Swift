//
//  ModifyPwdVC.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/8.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//修改密码

import UIKit

class ModifyPwdVC: BaseViewController,UITextFieldDelegate {

    let homeView = ModifyPwdView.init(frame:CGRect(x:0,y:0,width:WIDTH,height:HEIGHT+24))
    let loginBtn = LoginButtonViewController()
    var forgetPwdBut = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title:"修改支付密码")
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = COLOR_BACKGROUND
        self.view.addSubview(homeView)
        homeView.oldPasswordTF.delegate = self
        homeView.newPasswordTF.delegate = self
        homeView.againPasswordTF.delegate = self
        self.forgetPwd()
        loginBtn.loginButton(str: "完成", frame:CGRect(x:20,y:HEIGHT - 80.0 - 64,width:WIDTH - 40,height:48.0))
        loginBtn.loginButton.addTarget(self, action: #selector(clickBottomButton),for:.touchDown)
        self.view.addSubview(loginBtn.loginButton)
    }
    
    func forgetPwd() {
        forgetPwdBut = UIButton(frame: CGRect(x: WIDTH - 150, y: homeView.againPasswordView.frame.maxY + 20, width: 150, height: 20))
        forgetPwdBut.setTitle("", for: .normal)
        forgetPwdBut.titleLabel?.font = UIFont(name: ".PingFangSC-Regular", size: 16.0)
        forgetPwdBut.setTitleColor(COLOR_TEXT_GREY, for: .normal)
        let str = NSMutableAttributedString(string: "忘记支付密码？")
        let strRange: NSRange = NSRange.init(location: 0, length: str.length)
        str.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(value: 1), range: strRange)
        str.addAttribute(NSForegroundColorAttributeName, value: COLOR_TEXT_GREY, range: strRange)
        forgetPwdBut.setAttributedTitle(str, for: .normal)
        forgetPwdBut.addTarget(self, action: #selector(toForgetView), for:.touchDown)
        self.view.addSubview(forgetPwdBut)
    }
    
    func toForgetView() {
        let vc = ForgetPwdVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func clickBottomButton() {
        if homeView.newPasswordTF.text != homeView.againPasswordTF.text {
            if (homeView.againPasswordTF.text?.characters.count)! < 6 {
                SJProgressHUD.showOnlyText("密码不可小于6位")
            }else{
                SJProgressHUD.showOnlyText("两次密码不一致")
            }
        }else if homeView.newPasswordTF.text == homeView.againPasswordTF.text {
            if homeView.newPasswordTF.text  == "" {
                SJProgressHUD.showOnlyText("密码不能为空")
            }else if (homeView.newPasswordTF.text?.characters.count)! < 6 {
                SJProgressHUD.showOnlyText("密码不可少于6位")
            }else if homeView.oldPasswordTF.text == homeView.newPasswordTF.text{
                SJProgressHUD.showOnlyText("新密码不可与原密码相同")
            }else{
                self.requestUpdatePaymentPwd(oldPassword: homeView.oldPasswordTF.text!, newPassword: homeView.newPasswordTF.text!)
            }
        }
    }
   
    //MARK:修改密码请求
    func requestUpdatePaymentPwd(oldPassword:String,newPassword:String) {
        self.loadingImage()
        var dic = NSDictionary()
        dic = ["oldPassword":oldPassword,
               "newPassword":newPassword
        ]
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/agent/UpdatePaymentPassword", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = Response.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                SJProgressHUD.showOnlyText("密码修改成功")
                self.homeView.oldPasswordTF.text = ""
                self.homeView.newPasswordTF.text = ""
                self.homeView.againPasswordTF.text = ""
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existedLength: Int = (textField.text?.characters.count)!
        let selectedLength: Int = range.length
        let replaceLength: Int = (string.characters.count)
        
        if (existedLength - selectedLength + replaceLength > 6 ){
            return false
        }
        return true
    }
    
    //MARK:点击空白回收键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        homeView.oldPasswordTF.resignFirstResponder()
        homeView.newPasswordTF.resignFirstResponder()
        homeView.againPasswordTF.resignFirstResponder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

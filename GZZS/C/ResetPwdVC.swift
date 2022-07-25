//
//  ResetPwdVC.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/13.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class ResetPwdVC: BaseViewController,UITextFieldDelegate {

    let homeView = ResetPwdView.init(frame:CGRect(x:0,y:0,width:WIDTH,height:HEIGHT+24))
    let loginBtn = LoginButtonViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title: "重置支付密码")
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = COLOR_BACKGROUND
        
        self.view.addSubview(homeView)
        homeView.pwdTF.delegate = self
        homeView.confirmPwdTF.delegate = self
        
        self.bottomButtonView()
    }
    
    func bottomButtonView()  {
        
        loginBtn.loginButton(str: "完成", frame:CGRect(x:20,y:HEIGHT - 80 - 64,width:WIDTH-40,height:48.0))
        loginBtn.loginButton.addTarget(self, action: #selector(clickBottomButton),for:.touchDown)
        self.view.addSubview(loginBtn.loginButton)
    }
    
    func clickBottomButton() {
        if homeView.pwdTF.text != homeView.confirmPwdTF.text {
            if (homeView.pwdTF.text?.characters.count)! < 6 {
                SJProgressHUD.showOnlyText("密码不可少于6位")
            }else{
                SJProgressHUD.showOnlyText("两次密码不一致")
            }
        }else{
            if homeView.pwdTF.text == "" {
                SJProgressHUD.showOnlyText("密码不能为空")
            }else if (homeView.pwdTF.text?.characters.count)! < 6{
                SJProgressHUD.showOnlyText("密码不可少于6位")
            }else{
                self.requestForSetPay(password: homeView.pwdTF.text!)
            }
        }
    }
    
    //MARK:设置支付密码
    func requestForSetPay(password:String) {
        var dic = NSDictionary()
        dic = ["password":password]
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/agent/setpaymentpassword", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = CustormResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                SJProgressHUD.showOnlyText((response?.msg)!)
                self.homeView.pwdTF.text = ""
                self.homeView.confirmPwdTF.text = ""
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    //MARK:点击空白回收键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        homeView.pwdTF.resignFirstResponder()
        homeView.confirmPwdTF.resignFirstResponder()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existedLength: Int = (textField.text?.characters.count)!
        let selectedLength: Int = range.length
        let replaceLength: Int = (string.characters.count)
        
        if existedLength - selectedLength + replaceLength > 6 {
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

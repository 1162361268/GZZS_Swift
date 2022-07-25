//
//  ForgetPwdVC.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/11.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class ForgetPwdVC: BaseViewController,UITextFieldDelegate {

    var phone = String()
    let homeView = ForgetPwdView.init(frame:CGRect(x:0,y:0,width:WIDTH,height:HEIGHT+24))
    let countDown = TCCountDown.init(frame: CGRect(x:WIDTH - 20 - WIDTH*0.17,y:17,width:WIDTH * 0.17,height:25))
    let loginBtn = LoginButtonViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title:"忘记密码")
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = COLOR_BACKGROUND
        let user = UserDefaults.standard
        phone = user.string(forKey: "phone")!
        
        self.view.addSubview(homeView)
        homeView.phoneLabel.text = "手机号：" + NSString(string:phone).replacingCharacters(in: NSMakeRange(3, 4), with: "****")
        countDown.codeBtn.addTarget(self, action: #selector(clickSendCode),for:.touchUpInside)
        homeView.phoneView.addSubview(countDown.codeBtn)
        homeView.nameTF.delegate = self
        homeView.idTF.delegate = self
        homeView.veryCodeTF.delegate = self
        
        self.nextButtonView()
    }
    
    func nextButtonView()  {
        
        loginBtn.loginButton(str: "下一步", frame:CGRect(x:20,y:HEIGHT - 80 - 64,width:WIDTH-40,height:48.0))
        loginBtn.loginButton.addTarget(self, action: #selector(clickBottomButton),for:.touchDown)
        self.view.addSubview(loginBtn.loginButton)
    }
    
    func clickSendCode() {
        self.requestForVerifyCode()
    }
    
    func clickBottomButton() {
        if homeView.nameTF.text?.characters.count == 0 {
            SJProgressHUD.showOnlyText("请填写姓名")
        }else{
            if (homeView.idTF.text?.characters.count)! < 18 {
                SJProgressHUD.showOnlyText("身份证号码填写错误")
            }else{
                if (homeView.veryCodeTF.text?.characters.count)! < 6 {
                    SJProgressHUD.showOnlyText("验证码填写错误")
                }else{
                    self.requestCheckUserInfoResponse(name: homeView.nameTF.text!, idNumber: homeView.idTF.text!, veryCode: homeView.veryCodeTF.text!)
                }
            }
        }
    }
    
    //MARK:获取验证码
    func requestForVerifyCode(){
        var dic = NSDictionary()
        dic = ["phone":phone,
               "type":"2"]
        let post = RequestManager()
        post.postLogInRequestManagerWithURL(urlStr: "api/app/agent/sendverycode", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = Response.yy_model(withJSON: responseObject)
            if (response?.code == "0"){

            }else{
                self.countDown.isCounting = false//开启倒计时
                self.countDown.codeBtn.setTitle("获取验证码", for: .normal)
                
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    //MARK:验证用户信息
    func requestCheckUserInfoResponse(name:String,idNumber:String,veryCode:String){
        var dic = NSDictionary()
        dic = ["name":name,
               "idNumber":idNumber,
               "VeryCode":veryCode]
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/agent/CheckUserInfo", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = Response.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                let vc = ResetPwdVC()
                self.navigationController?.pushViewController(vc, animated: true)
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

        if textField == homeView.idTF {
            if existedLength - selectedLength + replaceLength > 18 {
                return false
            }
        }else if textField == homeView.veryCodeTF {
            if existedLength - selectedLength + replaceLength > 6 {
                return false
            }
        }
        return true
    }
    
    //MARK:点击空白回收键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        homeView.nameTF.resignFirstResponder()
        homeView.idTF.resignFirstResponder()
        homeView.veryCodeTF.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

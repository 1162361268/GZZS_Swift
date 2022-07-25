//
//  PayPasswordVC.swift
//  GZZS
//
//  Created by LiuHao on 2017/10/25.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class PayPasswordVC: BaseViewController {

    var pwdView = PayPasswordView()
    let loginBtn = LoginButtonViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.payButtonClick()
        self.view.addSubview(pwdView)
        self.pwdView.label1Button.addTarget(self, action: #selector(touchLabel1), for: .touchDown)
        self.pwdView.label2Button.addTarget(self, action: #selector(touchLabel2), for: .touchDown)
        self.view.addSubview(self.pwdView.label1Button)
        self.view.addSubview(self.pwdView.label2Button)
        self.loginButtonView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func loginButtonView(){
        loginBtn.loginButton(str: "提交", frame:CGRect(x:20,y:HEIGHT * 0.55,width:WIDTH-40,height:48.0))
        loginBtn.loginButton.addTarget(self, action: #selector(putIn),for:.touchDown)
        self.view.addSubview(loginBtn.loginButton)
    }
    
    func putIn(){
        if (self.pwdView.textField.text?.count == 6 && self.pwdView.confirmTextField.text?.count == 6) {
            if (self.pwdView.textField.text == self.pwdView.confirmTextField.text){
                self.requestForSetPayPwd(password: self.pwdView.textField.text! as NSString)
            }else{
                SJProgressHUD.showOnlyText("密码不一致，请重新输入")
            }
        }else{
            SJProgressHUD.showOnlyText("请输入密码")
        }
    }
    
    func touchLabel1(){
        self.pwdView.label_box1.isHidden = false
        self.pwdView.label_box2.isHidden = true
        self.pwdView.textField.becomeFirstResponder()
    }
    
    func touchLabel2(){
        self.pwdView.label_box1.isHidden = true
        self.pwdView.label_box2.isHidden = false
        self.pwdView.confirmTextField.becomeFirstResponder()
    }
    
    func payButtonClick(){
        self.pwdView.isHidden = false
        if(!self.pwdView.textField.becomeFirstResponder()){
            self.pwdView.textField.becomeFirstResponder()
        }
    }
    
    //MARK:密码输入完调此方法
    func PayPassword(view: PayPasswordView, Password: String) {
        print(Password)
        print("第1排")
        print(self.pwdView.textField.text!)
        print("第2排")
        print(self.pwdView.confirmTextField.text!)
    }
    
    //MARK:设置支付密码
    func requestForSetPayPwd(password:NSString) {
        self.loadingImage()
        var dic = NSDictionary()
        dic = ["password":password]
        
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/agent/setpaymentpassword", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = CustormResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                let user = UserDefaults.standard
                user.set("YES", forKey: "hasPwd")
                let viewCtl: UIViewController? = self.navigationController?.viewControllers[0]
                self.navigationController?.popToViewController(viewCtl!, animated: true)
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
        }) {(_ msg: String) -> Void in
            SJProgressHUD.showOnlyText(msg)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

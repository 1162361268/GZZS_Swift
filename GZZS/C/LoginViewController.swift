//
//  LoginViewController.swift
//  Liu
//
//  Created by LiuHao on 2017/4/18.
//  Copyright © 2017年 LiuHao. All rights reserved.
//登录

import UIKit

class LoginViewController : BaseViewController,UITextFieldDelegate{

    let mobileField = UITextField()
    let mobileLoginView = UIView()
    var codeButton = UIButton()
    let codeField = UITextField()
    let countDown = TCCountDown.init(frame: CGRect(x:WIDTH - 20 - WIDTH*0.17,y:0,width:WIDTH * 0.17,height:25))
    let loginBtn = LoginButtonViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title: "登录")
        self.backGroundView()
        self.view.addSubview(self.mobileLoginHomeView())
        self.loginButtonView()
        #if DEBUG
            self.liuhao()
        #else
            
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func backGroundView(){
        let backGroundImage = UIImageView.init(frame: CGRect(x:100,y:120,width:WIDTH-200,height:(WIDTH-200)*0.2))
        backGroundImage.image = #imageLiteral(resourceName: "loginImage.png")
        self.view.addSubview(backGroundImage)
        
    }
    
    func liuhao(){
        let btn1 = UIButton.init(frame: CGRect.init(x: WIDTH-100, y: 0, width: 100, height: 100))
        btn1.addTarget(self, action: #selector(liuBtn1), for: .touchDown)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton.init(frame: CGRect.init(x: 0, y: HEIGHT-100, width: 100, height: 100))
        btn2.addTarget(self, action: #selector(liuBtn2), for: .touchDown)
        self.view.addSubview(btn2)
    }
    
    func liuBtn1(){
        let vc = test()
        present(vc, animated: true) {_ in}
    }
    
    func liuBtn2(){
        let aler = UIAlertView.init(title: UserDefaults.standard.object(forKey: "host") as? String, message: "api:" + HOST_URL + "。文件上传api:" + HOST_URLAdd, delegate: self, cancelButtonTitle: "ok")
        aler.show()
    }
    
    func mobileLoginHomeView() -> UIView  {
        mobileLoginView.frame = CGRect(x:0,y:HEIGHT*0.38,width:WIDTH,height:HEIGHT-(HEIGHT*0.38)-100)
        mobileLoginView.backgroundColor = UIColor.white
        
        mobileField.frame = CGRect(x:20,y:0,width:WIDTH*0.65,height:25)
        mobileField.attributedPlaceholder = NSAttributedString.init(string: "请输入您的手机号码")
        mobileField.textColor = COLOR_LINE_LIGHTGRAY
        mobileField.tag = 0
        mobileField.delegate = self
        mobileField.keyboardType = .numberPad
        mobileField.resignFirstResponder()
        mobileLoginView.addSubview(mobileField)
        
        countDown.codeBtn.addTarget(self, action: #selector(clickSendCode),for:.touchUpInside)
        mobileLoginView.addSubview(countDown.codeBtn)
        
        let line = UILabel.init(frame: CGRect(x:20,y:mobileField.frame.maxY + 5,width:WIDTH-40,height:1))
        line.backgroundColor = COLOR_LINE_GRAY
        mobileLoginView.addSubview(line)
        
        codeField.frame = CGRect(x:20,y:mobileField.frame.height+45,width:WIDTH * 0.65 ,height:25)
        codeField.attributedPlaceholder = NSAttributedString.init(string: "请输入您的验证码")
        codeField.tag = 1
        codeField.textColor = COLOR_LINE_LIGHTGRAY
        codeField.delegate = self
        codeField.keyboardType = .numberPad
        codeField.resignFirstResponder()
        mobileLoginView.addSubview(codeField)
        
        let line2 = UILabel.init(frame: CGRect(x:20,y:codeField.frame.maxY + 5,width:WIDTH-40,height:1))
        line2.backgroundColor = COLOR_LINE_GRAY
        mobileLoginView.addSubview(line2)
        

        return mobileLoginView
    }
    
    func loginButtonView()  {
        
        loginBtn.loginButton(str: "登录", frame:CGRect(x:20,y:HEIGHT * 0.65,width:WIDTH-40,height:48.0))
        loginBtn.loginButton.addTarget(self, action: #selector(clickBottomButton),for:.touchDown)
        self.view.addSubview(loginBtn.loginButton)

    }
    
    func clickBottomButton() {

        if (mobileField.text!.characters.count == 11) {
            self.requestForMobileLogin()
        }
    }
    
    
    func clickSendCode() {
        if(mobileField.text!.characters.count  == 0){
            let alert = UIAlertView.init(title: nil, message: "请输入手机号码", delegate:self, cancelButtonTitle: "确定")
            alert.show()
        }else if(mobileField.text!.characters.count == 11){
            countDown.isCounting = true//开启倒计时
            self.requestSendverycode()
        }else{
            let alert = UIAlertView.init(title: nil, message:"请输入正确的手机号码", delegate:self, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    //MARK:获取验证码
    func requestSendverycode(){
        var dic = NSDictionary()
        dic = ["phone":mobileField.text!,
               "type":"1"]
        
        let post = RequestManager()
        post.postLogInRequestManagerWithURL(urlStr: "api/app/agent/sendverycode", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = Response.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                print(response?.code as Any)
            }else{
                self.countDown.isCounting = false//开启倒计时
                self.countDown.codeBtn.setTitle("获取验证码", for: .normal)

                SJProgressHUD.showOnlyText((response?.msg)!)
                
            }
        }) {(_ msg: String) -> Void in
            print(msg)
        }
    }
    
    //MARK:登录
    func requestForMobileLogin() {
        var dic = NSDictionary()
        dic = ["phone":mobileField.text!,
               "veryCode":codeField.text!]
        
        let post = RequestManager()
        post.postLogInRequestManagerWithURL(urlStr: "api/app/agent/login", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = CustormResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                print(response?.code as Any)
                
                let user = UserDefaults.standard
                user.set(response?.data.userId, forKey: "userId")
                user.set(response?.data.token, forKey: "token")
                user.set(response?.data.phone, forKey: "phone")
                self.requestForRegister()
                if(response?.data.hasPwd)!{
                    user.set("YES", forKey: "hasPwd")
                }else{
                    user.set("NO", forKey: "hasPwd")
                }
                
                let viewCtl: UIViewController? = self.navigationController?.viewControllers[0]
                self.navigationController?.popToViewController(viewCtl!, animated: true)

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginBack"), object: nil, userInfo: nil)
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
            
        }) {(_ msg: String) -> Void in
            SJProgressHUD.showOnlyText(msg)
        }
    }
    
    //MARK:推送注册
    func requestForRegister(){
        let str: String = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let user = UserDefaults.standard
        let deviceToken = user.string(forKey: "deviceToken")
        let userId = user.string(forKey: "userId")
        var dic2 = NSDictionary()
        dic2 = ["token": "\(String(describing: userId))",
               "appId": "1005",
               "deviceId": "\(String(describing: str))",
               "brand": "apple",
               "deviceTokens": [["deviceToken": "\(String(describing: deviceToken))",
                                 "channelId": "1"]]]
        let post = RequestManager()
        post.postPUSHManagerWithURL(urlStr: "api/Push/Register", dic: dic2 as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = Response.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                print(response?.code as Any)
                
            }else{
            }
            
        }) {(_ msg: String) -> Void in
        }


    }
    
    
    //MARK:输入位数限制
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existedLength: Int = (textField.text?.characters.count)!
        let selectedLength: Int = range.length
        let replaceLength: Int = (string.characters.count)
        
        if string.characters.count == 0 {
            return true
        }
        
        if (textField == mobileField) {
            if existedLength - selectedLength + replaceLength == 11 {
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.first), userInfo: nil, repeats: false)
            }
            if existedLength - selectedLength + replaceLength > 11 {
                return false
            }
        }else if(textField == codeField){
            if existedLength - selectedLength + replaceLength == 6 {
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.recoveryKeyboard), userInfo: nil, repeats: false)
            }
            if existedLength - selectedLength + replaceLength > 6 {
                return false
            }
        }
        return true
    }
    
    func recoveryKeyboard() {
        mobileField.resignFirstResponder()
        codeField.resignFirstResponder()
    }
    
    func first() {
        codeField.becomeFirstResponder()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        mobileField.resignFirstResponder()
        codeField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

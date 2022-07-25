//
//  ElectricityController.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/5.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//交电费

import UIKit

class ElectricityController: BaseViewController,UITextFieldDelegate,popPayDelegate {
    var popPayView: popPayPwdView?
    var judgment = AmountJudgment()
    let loginBtn = LoginButtonViewController()
    let homeView = ElectricityView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT))

    var  limitation = String()
    var  contractNo = String()
    var  billKey    = String()
    var  companyId  = String()
    var  paymentDate = String()
    var  delayFine  = String()
    var  customerName = String()
    var  payAmount  = String()
    var  balance    = String()
    var  billList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title:"交电费")
        self.navigationController?.navigationBar.isTranslucent = false
        homeView.publicParamNameField.delegate = self
        homeView.amountField.delegate = self
        self.view.addSubview(homeView)
        
        loginBtn.loginButton(str: "确认缴费", frame:CGRect(x:20,y:350,width:WIDTH-40,height:48.0))
        loginBtn.loginButton.addTarget(self, action: #selector(clickCheckButton),for:.touchDown)
        self.view.addSubview(loginBtn.loginButton)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.loadDismiss()
    }
    
    //MARK:判断账号位数
    func clickCheckButton() {
        if (Double(homeView.amountField.text!)  == 0 || homeView.amountField.text == "") {
            SJProgressHUD.showOnlyText("输入金额不能为0")
        }else{
            if (homeView.publicParamNameField.text?.characters.count == 16) {
                if homeView.amountField.text! > self.limitation {
                    let alert = UIAlertView.init(title: "提示", message: "可用额度不足，请尽快回款", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                }else{
                    self.payPwd()
                }
            }else{
                let alert = UIAlertView.init(title: "请输入正确的客户编号", message: nil, delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
        }
    }
    
    //MARK:查询电费
    func requestForqueryPublicUtilityAmt() {
        self.loadingImage()
        var dic = NSDictionary()
        dic = ["billKey":homeView.publicParamNameField.text!]
        
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/finance/QueryPowerFee", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = QueryPowerFeeResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                print(response?.code as Any)
                if (response?.data.count)! > 0{
                    let list:QueryPowerFeeList = response?.data[0] as! QueryPowerFeeList
                    self.limitation     = (list.limitation)
                    self.contractNo     = (list.contractNo)
                    self.billKey        = (list.billKey)
                    self.companyId      = (list.companyId)
                    self.paymentDate    = (list.paymentDate)
                    self.delayFine      = (list.delayFine)
                    self.customerName   = (list.customerName)
                    self.payAmount      = (list.payAmount)
                    self.balance        = (list.balance)
                    
                    if (Double(self.payAmount)!) > 0{
                        self.homeView.payAmountLabel.text = "欠费金额：" + self.payAmount
                    }else if((Double(self.payAmount)!) == 0){
                        self.homeView.payAmountLabel.text = "欠费金额：未欠费"
                    }
                }else{
                    let alert = UIAlertView.init(title: "未查到账单，请核实缴费单号", message: nil, delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                }
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    //MARK:交电费
    func requestForPay(pwd:String) {
        self.loadingImage()
        var dic = NSDictionary()
        dic = ["billKey":self.billKey,
               "payAmount":homeView.amountField.text!,
               "paymentDate":self.paymentDate,
               "delayFine":self.delayFine,
               "customerName":self.customerName,
               "contractNo":self.contractNo,
               "payPwd":pwd]

        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/finance/PayPowerFee", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = PayMentResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                let alert = UIAlertView.init(title: "缴费成功", message: nil, delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
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
        
        if (textField == homeView.publicParamNameField) {
            if existedLength - selectedLength + replaceLength == 16 {
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.recoveryKeyboard), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.requestForqueryPublicUtilityAmt), userInfo: nil, repeats: false)

            }
            if existedLength - selectedLength + replaceLength > 16 {
                return false
            }
        }else if(textField == homeView.amountField){
           return judgment.judgment(money: homeView.amountField.text!, string: string, range: range)
        }
        return true
    }
    
    
    //MARK:调起密码框
    func payPwd()  {
        popPayView = popPayPwdView()
        popPayView!.delegate = self
        popPayView!.pop(lim:self.limitation,amount:self.homeView.amountField.text!)

    }
    
    //MARK:密码输入结束
    func compareCode(_ payCode: String) {
        self.requestForPay(pwd: payCode)
    }
    
    //MARK:点击空白回收键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        homeView.publicParamNameField.resignFirstResponder()
        homeView.amountField.resignFirstResponder()
    }
    
    func recoveryKeyboard() {
        homeView.publicParamNameField.resignFirstResponder()
        homeView.amountField.resignFirstResponder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

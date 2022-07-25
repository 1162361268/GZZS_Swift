//
//  PhonerateViewController.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/6.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//交话费

import UIKit
import AddressBook
import AddressBookUI

class PhonerateViewController: BaseViewController,ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,popPayDelegate{
    var popPayView: popPayPwdView?
    let homeView = PhonerateView.init(frame:CGRect(x:0,y:0,width:WIDTH,height:HEIGHT+24))
    var amtList = NSArray()
    var collect : UICollectionView?
    var selectedCell = PhonerateCollectionCell()
    var amount = String()
    var limitationAmt = String()
    var count = CGFloat()   //金额cell的行数
    var adTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle(title: "交话费")
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(homeView)
        self.homeView.contactButton.addTarget(self, action: #selector(phone), for: .touchDown)
        self.homeView.phoneNumberTextfield.delegate = self
        amtList = (["10","30","50","100","200","500"])
        self.view.addSubview(self.amountButtonView())
        adTextview()
    }
    
    func amountButtonView() -> UIView{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(WIDTH - 40)/3,height:(WIDTH - 40)/3)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        collect = UICollectionView.init(frame: CGRect(x:0,y:136,width:WIDTH,height:WIDTH + 10), collectionViewLayout: layout)
        collect?.backgroundColor = COLOR_WHITE
        collect?.delegate = self
        collect?.dataSource = self
        collect?.sizeToFit()
        collect?.register(PhonerateCollectionCell.self, forCellWithReuseIdentifier: "cellid")
        collect?.backgroundColor = COLOR_WHITE
        return collect!
        
    }
    
    func adTextview() {
        
        if self.amtList.count < 7{
            self.count = 2
        }else{
            self.count = 3
        }

        adTextView = UITextView.init(frame: CGRect.init(x: 10, y: (collect?.frame.minY)! + (WIDTH / 3) * count , width: WIDTH-20, height: 100))
        adTextView.text = "*处于欠费状态的手机，为避免充值后仍为欠费状态，建议充值金额高于欠费金额\n*支付成功后请在交易记录查看缴费结果"
        adTextView.textColor = COLOR_GREY
        self.view.addSubview(adTextView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amtList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! PhonerateCollectionCell
        cell.backgroundColor = COLOR_WHITE
        cell.amountLabel.text = "\(amtList[indexPath.row])元"
        cell.amountLabel.textColor = COLOR_RED_V2
        cell.amountLabel.layer.masksToBounds = true
        cell.amountLabel.layer.cornerRadius = 5.0
        cell.amountLabel.layer.borderWidth = 0.5
        cell.amountLabel.layer.borderColor = COLOR_RED_V2.cgColor
        cell.amountLabel.textAlignment = .center
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("\(amtList[indexPath.row])元")
        
        if (homeView.phoneNumberTextfield.text?.characters.count)! < 11{
            let alert = UIAlertView.init(title: "提示", message: "请输入或选择手机号", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }else{
            let cell :PhonerateCollectionCell = collectionView.cellForItem(at: indexPath) as! PhonerateCollectionCell
            cell.backgroundColor = COLOR_RED_V2
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5.0
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = COLOR_RED_V2.cgColor
            cell.amountLabel.textColor = COLOR_WHITE
            if !self.selectedCell.isEqual(nil){
                if !self.selectedCell.isEqual(cell) {
                    selectedCell.amountLabel.textColor = COLOR_RED_V2
                    selectedCell.backgroundColor = COLOR_WHITE
                }
            }
            selectedCell = cell
            amount = "\(amtList[indexPath.row])"
            if amount > limitationAmt {
                let alert = UIAlertView.init(title: nil, message: "可用额度不足，请尽快回款", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                selectedCell.amountLabel.textColor = COLOR_RED_V2
                selectedCell.backgroundColor = COLOR_WHITE
            }else{
                payButtonClick()
            }
        }
    }
    
    func payButtonClick() {
        popPayView = popPayPwdView()
        popPayView!.delegate = self
        popPayView!.pop(lim:self.limitationAmt,amount:amount)
    }
    
    //MARK:密码输入结束
    func compareCode(_ payCode: String) {
        requestForPayPhoneFee(rechargePhone: self.homeView.phoneNumberTextfield.text!, amount: amount, payPwd: payCode)
    }

    //MARK:调起通讯录
    func phone() {
        self.homeView.homeLocationLabel.text = ""  //清空归属地
        let pNC = ABPeoplePickerNavigationController()
        pNC.peoplePickerDelegate = self
        
        if (UIDevice.current.systemVersion as NSString).floatValue >= 8.0 {
            pNC.predicateForSelectionOfPerson = NSPredicate(value: false)
        }
        present(pNC, animated: true) { _ in }
    }
    
    //MARK:获取话费列表和限额
    func requestForPhoneQuerybills() {
        self.loadingImage()
        var dic = NSDictionary()
        dic = ["rechargePhone":self.homeView.phoneNumberTextfield.text!]
        
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/finance/GetPayList", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = EcommerceResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                if response?.data.mobileInfo.retCode == "1" {
                    self.homeView.homeLocationLabel.text =  (response?.data.mobileInfo.areaName)! + (response?.data.mobileInfo.busName)!
                }
                self.limitationAmt = (response?.data.limitation)!
                self.amtList = (response?.data.list)!
                self.collect?.reloadData()
                self.adTextView.removeFromSuperview()
                self.adTextview()

            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    //MARK:交话费
    func requestForPayPhoneFee(rechargePhone:String,amount:String,payPwd:String) {
        self.loadingImage()
        var dic = NSDictionary()
        dic = ["rechargePhone":rechargePhone,
               "amount":amount,
               "payPwd":payPwd]
        
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/finance/PayPhoneFee", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = PayMentResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                let alert = UIAlertView.init(title: "充值成功", message: nil, delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }else{
                SJProgressHUD.showOnlyText((response?.msg)!)
                self.selectedCell.backgroundColor = COLOR_WHITE
                self.selectedCell.amountLabel.textColor = COLOR_RED_V2
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        
        let phoneValues:ABMutableMultiValue? = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        if phoneValues != nil && identifier >= 0{
            let value = ABMultiValueCopyValueAtIndex(phoneValues, CFIndex(identifier))
            let phone = value?.takeRetainedValue() as! String
            let cleaned: String = (phone.components(separatedBy: CharacterSet.whitespaces) as NSArray).componentsJoined(by: "")
            let phoneNumber:NSString = cleaned.replacingOccurrences(of: "-", with: "") as NSString
            let phoneNumber1:NSString = phoneNumber.replacingOccurrences(of: "+86", with: "") as NSString
            if phoneNumber1 != "" && phoneNumber1.length == 11 {
                self.homeView.phoneNumberTextfield.text = phoneNumber1 as String
                self.requestForPhoneQuerybills()
            }else{
                let alert = UIAlertView.init(title: "错误", message: "请选择正确手机号", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.homeView.homeLocationLabel.text = ""
    }
    
    //MARK:输入位数限制
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existedLength: Int = (textField.text?.characters.count)!
        let selectedLength: Int = range.length
        let replaceLength: Int = (string.characters.count)
        
        if (textField == self.homeView.phoneNumberTextfield) {
            if existedLength - selectedLength + replaceLength == 11 {
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.recoveryKeyboard), userInfo: nil, repeats: false)
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(requestForPhoneQuerybills), userInfo: nil, repeats: false)
            }
            if existedLength - selectedLength + replaceLength > 11 {
                return false
            }
        }
        return true
    }
    
    //MARK:点击空白回收键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.homeView.phoneNumberTextfield.resignFirstResponder()
    }
    
    func recoveryKeyboard() {
        self.homeView.phoneNumberTextfield.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

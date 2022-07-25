//
//  LHWxPayVC.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/15.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class LHWxPayVC: BaseViewController {

    var body = NSDictionary()
    var appId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingImage()
        self.wxPay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.loadDismiss()
    }
    
    func wxPay() {
        appId = String(describing: body["appId"])
        WXApi.registerApp("wx462e5ae5c761b019")

        if WXApi.isWXAppInstalled() {
            let stamp : String = String(describing: body["timeStamp"])
            let req = PayReq.init()
            req.partnerId = String(describing: body["timeStamp"])
            req.prepayId = String(describing: body["prepayId"])
            req.nonceStr = String(describing: body["nonceStr"])
            req.timeStamp = UInt32(CFStringGetIntValue(stamp as CFString))
            req.package = String(describing: body["package"])
            req.sign = String(describing: body["sign"])
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.noti), name: NSNotification.Name(rawValue: "weixinPay"), object: nil)
            
            WXApi.send(req)
        }else{
            let alert = UIAlertView.init(title: "您尚未安装微信", message: "请安装微信", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    func noti(noti:Notification) {
        if String(describing: noti.object) == "成功" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wechatPay"), object: "true")
            self.navigationController?.popViewController(animated: true)
            self.setResult(resultCode: -1, result: nil)
        }else if String(describing: noti.object) == "未知状态"{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wechatPay"), object:"unknown")
            self.navigationController?.popViewController(animated: true)
            self.setResult(resultCode: 1, result: noti.object! as AnyObject)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wechatPay"), object:"false")
            self.navigationController?.popViewController(animated: true)
            self.setResult(resultCode: 0, result: noti.object! as AnyObject)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

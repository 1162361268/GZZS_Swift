//
//  BaseViewController.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/8/30.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

@objc protocol VCResultDelegate {
    func vcRequestCode(requestCode:Int,resultCode:Int,result:AnyObject?)
}

class VCResultClass {
    weak var delegate : VCResultDelegate?
}

class BaseViewController: UIViewController,VCResultDelegate {
    
    func vcRequestCode(requestCode: Int, resultCode: Int, result: AnyObject?) {
        
    }

    var VCResultInstance = VCResultClass()
    
    var loadImage = Loading()
    var viewControllerDic = NSMutableDictionary.init()
    var resultDelegate = VCResultDelegate.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_WHITE
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func navTitle(title:String) {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 60))
        label.text = title
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = COLOR_GREY
        label.textAlignment = .center
        self.navigationItem.titleView = label
        
        self.navigationController?.navigationBar.barTintColor = COLOR_WHITE  //背景颜色
        self.navigationController?.navigationBar.tintColor = COLOR_RED_V2   //返回箭头颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: COLOR_GREY]  //标题颜色
    }
    
    func loadingImage() {
        SJProgressHUD.showWaitingWithImages(loadImage.loading())
    }
    
    func loadDismiss() {
        SJProgressHUD.dismiss()
    }
    
    func clickConfirmButton() {
        let user = UserDefaults.standard
        user.set("", forKey: "userId")
        user.removeObject(forKey: "phone")
        user.removeObject(forKey: "token")
        user.removeObject(forKey: "hasPwd")
        
        let islogin = IsLogined()
        if (!islogin.isLogined()) {
            let vc = LoginViewController()
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    func setResult(resultCode:Int,result:AnyObject?) {
        let keys : Array = viewControllerDic.allKeys
        for key in keys {
            let controller :BaseViewController = viewControllerDic[key] as! BaseViewController
              controller.vcRequestCode(requestCode: Int(String(describing: key))! , resultCode: resultCode, result: result)
        }
        viewControllerDic.removeAllObjects()
    }
    
    func startViewControllerForResult(vc:BaseViewController,requestCode:Int) {
        vc.viewControllerDic.setValue(self, forKey: String(requestCode))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentViewControllerForResult(vc:BaseViewController,requestCode:Int){
        vc.viewControllerDic.setValue(self, forKey: String(requestCode))
        present(vc, animated: true, completion: {(_: Void) -> Void in
                vc.view.superview?.backgroundColor = UIColor.clear
        })
    }
    
    func statuseBarStyle() {
        let mgr = AFNetworkReachabilityManager.shared()
        mgr.setReachabilityStatusChange { (status:AFNetworkReachabilityStatus) in
            if(status.rawValue == -1){
                print("未知网络")
            }else if(status.rawValue == 0){
                print("没有网络（断网）")
            }else if(status.rawValue == 1){
                print("手机自带网络")
            }else if(status.rawValue == 2){
                print("WIFI")
            }
        }
        mgr.startMonitoring()
    }

    
    func testMethod() {
        print("Test!")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

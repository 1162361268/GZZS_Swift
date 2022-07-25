//
//  ReactSwiftView.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/9/4.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

class ReactSwiftView: UIView {

     override init(frame:CGRect){
     super.init(frame: frame)
        let pathDocuments: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as? String ?? ""
        let createPath: String = "\(pathDocuments)/lhjs.data"
        if createPath != "" {
            if !FileManager.default.fileExists(atPath: "\(createPath)/index.ios.jsbundle") {
                let jsCodeLocation: URL? = Bundle.main.url(forResource: "index.ios", withExtension: "jsbundle")
                loadJSbundle(withJsCodeLocation: jsCodeLocation!)
            }else{
                let jsCodeLocation = URL(string: "\(createPath)/index.ios.jsbundle")
                loadJSbundle(withJsCodeLocation: jsCodeLocation!)
            }
        }else{
            let jsCodeLocation: URL? = Bundle.main.url(forResource: "index.ios", withExtension: "jsbundle")
            loadJSbundle(withJsCodeLocation: jsCodeLocation!)
    }
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadJSbundle(withJsCodeLocation jsCodeLocation: URL) {
        let props: Dictionary = getUserInfo() as Dictionary
        print("---------------------------------------------------\(props)---------------------------------------------------")
        let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "test", initialProperties: props, launchOptions: nil)
        addSubview(rootView ?? UIView())
        rootView?.frame = bounds
    }
    
    func getUserInfo() -> NSDictionary {
        
        let user = UserDefaults.standard
        var userId = user.string(forKey: "userId")
        var phone = user.string(forKey: "phone")
        var token = user.string(forKey: "token")
//
//        var phone: String = user["phone"] as? String ?? ""
//        var token: String? = user.object(forKey: "token") as? String
        if(userId == nil){
            userId = ""
        }
        if(phone == nil){
            phone = ""
        }
        if(token == nil){
            token = ""
        }
        
        var infoDic: [AnyHashable: Any]? = Bundle.main.infoDictionary
        let appVersion: String = infoDic?["CFBundleShortVersionString"] as? String ?? ""
        
        var dic = NSDictionary()
        dic = ["userId":userId!,
               "phone":phone!,
               "token":token!,
               "version":appVersion,
               "host":HOST_URL,
               "imageHost":HOST_URLAdd]
        
        return dic
    }
    
}

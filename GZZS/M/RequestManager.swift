//
//  RequestManager.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/8/31.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

class RequestManager: NSObject {

    typealias SuccessResponds = (_ responseObject: Any) -> Void
    typealias ErrorResponds = (_ msg: String) -> Void
    
    func requestWithHTTPS() {
        var securityPolocy = AFSecurityPolicy()
        securityPolocy = AFSecurityPolicy.default()
        securityPolocy.allowInvalidCertificates = true
        securityPolocy.validatesDomainName = false
    }
    
    func postLogInRequestManagerWithURL(urlStr:String,dic:NSDictionary,success:@escaping SuccessResponds,errorMessage: @escaping ErrorResponds){
        self.requestWithHTTPS()
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 60.0
        manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        
        manager.post(HOST_URL+urlStr, parameters: dic, success: { (_ operation: AFHTTPRequestOperation, _ responseObject: Any) -> Void in
            SJProgressHUD.dismiss()
            success(responseObject)
        }) { (_ operation: AFHTTPRequestOperation?, _ error: Error?) -> Void in
            errorMessage("网络连接失败，请稍后再试")
        }
      }
    
    
    func postRequestManagerWithURL(urlStr:String,dic:NSDictionary,success:@escaping SuccessResponds,errorMessage: @escaping ErrorResponds){

        self.requestWithHTTPS()
        
        var dic1:Dictionary = dic as Dictionary
        let dic2: Dictionary = getUserInfo() as Dictionary
        
        for(key,value) in dic2{
            dic1[key] = value
        }
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 60.0
        manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        
        manager.post(HOST_URL+urlStr, parameters: dic1, success: { (_ operation: AFHTTPRequestOperation, _ responseObject: Any) -> Void in
            SJProgressHUD.dismiss()

            success(responseObject)
            
        }) { (_ operation: AFHTTPRequestOperation?, _ error: Error?) -> Void in
            errorMessage("error")
        }
    }
    
    func postPUSHManagerWithURL(urlStr:String,dic:NSDictionary,success:@escaping SuccessResponds,errorMessage: @escaping ErrorResponds){
        
        self.requestWithHTTPS()
        
        var dic1:Dictionary = dic as Dictionary
        let dic2: Dictionary = getUserInfo() as Dictionary
        
        for(key,value) in dic2{
            dic1[key] = value
        }
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        manager.requestSerializer.timeoutInterval = 60.0
        manager.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        
        manager.post(HOST_PUSH_URL + urlStr, parameters: dic1, success: { (_ operation: AFHTTPRequestOperation, _ responseObject: Any) -> Void in
            SJProgressHUD.dismiss()
            
            success(responseObject)
            
        }) { (_ operation: AFHTTPRequestOperation?, _ error: Error?) -> Void in
            errorMessage("error")
        }
    }
    
    func getUserInfo() -> NSDictionary {
        
        let user = UserDefaults.standard
        var userId = user.string(forKey: "userId")
        var phone = user.string(forKey: "phone")
        var token = user.string(forKey: "token")
        
        if((userId == nil)){
            userId = ""
        }
        if((phone == nil)){
            phone = ""
        }
        if((token == nil)){
            token = ""
        }
        
        var infoDic: [AnyHashable: Any]? = Bundle.main.infoDictionary
        let appVersion: String = infoDic?["CFBundleShortVersionString"] as? String ?? ""
        
        var dic = NSDictionary()
        dic = ["userId":userId!,
               "phone":phone!,
               "token":token!,
               "version":appVersion]
        
        return dic
    }
    
    }

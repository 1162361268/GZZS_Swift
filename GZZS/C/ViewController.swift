//
//  ViewController.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/5.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//首页

import UIKit

class ViewController: BaseViewController,BMKLocationServiceDelegate,TZImagePickerControllerDelegate {
    var reactView:ReactSwiftView = ReactSwiftView()
    let user = UserDefaults.standard
    var callBack = String()
    var wxPayBodyDic = NSDictionary()
    var isFirstClick = Bool()
    var indicatorView = UIActivityIndicatorView()
    var isPushed = Bool()
    var locationService: BMKLocationService!
    var imageArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationService = BMKLocationService()
        reactView = ReactSwiftView.init(frame: CGRect(x:0,y:0,width:WIDTH,height:UIScreen.main.applicationFrame.size.height+24))
        self.view.addSubview(reactView)

        isFirstClick = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.noti), name: NSNotification.Name(rawValue: "RNOpenOC"), object: nil)
        self.requestGetPersonalInfo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginSuccess), name: NSNotification.Name(rawValue: CUSTOM_LOGIN_SUCCEED), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginFaile), name: NSNotification.Name(rawValue: CUSTOM_LOGIN_ERROR_USER), object: nil)
        self.statuseBarStyle()
        print(self.statuseBarStyle())
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.isLogin), name: NSNotification.Name(rawValue: "loginBack"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated:true)
        locationService.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        locationService.delegate = self
    }
    
    func isLogin()  {
        let islogin = IsLogined()
        if (islogin.isLogined()) {
            if (islogin.isHasPwd()) {
                self.requestGetPersonalInfo()
                
                if !self.reactView.isEqual(nil)  {
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.reactView = ReactSwiftView.init(frame: CGRect(x:0,y:0,width:UIScreen.main.applicationFrame.size.width,height:UIScreen.main.applicationFrame.size.height+24))
                        self.view.addSubview(self.reactView)
                    })

                }else{
                    
                }
            }else{
                let vc = PayPasswordVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
      }
    
    func noti(noti:Notification) {
        if ((noti.object) != nil){
            var dic = NSDictionary()
            dic = noti.object as! NSDictionary
            if( dic["mission"] != nil){
                if dic["mission"] as! String == "electricity"{      //电费
                    self.electricity()
                }else if dic["mission"] as! String == "phoneBill"{      //话费
                    self.phoneBill()
                }else if dic["mission"] as! String == "backMoney"{      //回款

                }else if dic["mission"] as! String == "openCamera"{     //传图

                }else if dic["mission"] as! String == "history"{        //交易记录

                }else if dic["mission"] as! String == "rank"{           //发卡排名

                }else if dic["mission"] as! String == "editPayPassword"{   //修改密码
                    self.editPayPassword()
                }else if dic["mission"] as! String == "login"{              //登录
                    self.login()
                }else if dic["mission"] as! String == "logout"{             //退出
                    self.logout()
                }else if dic["mission"] as! String == "QRCode"{             //扫码
                    callBack = dic["callBack"]! as! String
                    self.QRCode()
                }else if dic["mission"] as! String == "customerService"{     //在线客服
                    self.clickAction()
                }else if dic["mission"] as! String == "WxPay"{                  //微信支付
                    callBack = dic["callBack"]! as! String
                    wxPayBodyDic = dic["data"]! as! NSDictionary
                    self.WxPay(body: wxPayBodyDic)
                }else if dic["mission"] as! String == "cardBill"{               //账单
                    
                }
            }else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RNOpenOC"), object: nil)
            }
        }
    }
    
    func login(){
        let vc = LoginViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func electricity() {
        let vc = ElectricityController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func phoneBill()  {
        let vc = PhonerateViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    //地图
    func toLocationMap(){
        let vc = LocationDemoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logout() {
        let alertController = UIAlertController(title: nil, message: self.user.string(forKey: "phone")! + "您是否要退出登录", preferredStyle:.actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "退出登录", style: .destructive, handler:{action in
            self.requestForLogout()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func editPayPassword() {
        let vc = ModifyPwdVC()
        self.navigationController!.pushViewController(vc, animated: true)
    }

    func QRCode() {
        let vc = QRCodeReaderVC()
        let nVC = UINavigationController(rootViewController: vc as? UIViewController ?? UIViewController())
        present(nVC, animated: true, completion: {() -> Void in
            vc.callBack = self.callBack
        })
    }
    
    func password(){
        let vc = PayPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func WxPay(body:NSDictionary) {
        let vc = LHWxPayVC()
        vc.body = body
        self.startViewControllerForResult(vc: vc, requestCode: 0)
    }
    
    //开始定位
    func location() {
        locationService.startUserLocationService()
    }
    
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        print("heading is \(userLocation.heading)")
    }
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        
        let geocoder = CLGeocoder.init()
        geocoder.reverseGeocodeLocation(userLocation.location, completionHandler: {(_ placemarks: [CLPlacemark]?, _ error: Error?) -> Void in
            for place: CLPlacemark in placemarks! {
                let dic = ["address": "\(String(describing: place.country))\(String(describing: place.administrativeArea))\(String(describing: place.locality))\(String(describing: place.subLocality))\(String(describing: place.name))",
                    "city": "\(String(describing: place.locality))",
                    "country": "\(String(describing: place.country))",
                    "district": "\(String(describing: place.subLocality))",
                    "locationDescribe": "\(String(describing: place.name))",
                    "latitude": "\(userLocation.location.coordinate.latitude)",
                    "longitude": "\(userLocation.location.coordinate.longitude)",
                    "province": "\(String(describing: place.administrativeArea))",
                    "street": "\(String(describing: place.thoroughfare))"]
                print("\(dic)")
                self.locationService.stopUserLocationService()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.callBack), object: dic)
            }
        })
    }
    
    //调起相册&相机
    func pushTZImagePickerController() {
        let imagePickerVc = TZImagePickerController(maxImagesCount: 9, columnNumber: 4, delegate: self, pushPhotoPickerVc: true)
        
        present(imagePickerVc ?? UIViewController(), animated: true) { _ in }
        
    }
    
    //返回选择的照片
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        imageArray = photos! as NSArray
        print("以下是选择的照片")
        print(imageArray)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: callBack), object: imageArray)
    }
    
    func requestGetPersonalInfo() {
        
        let dic = NSDictionary()
        
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr:"api/app/agent/GetPersonalInfo", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = GetPersonalInfoResponse.yy_model(withJSON: responseObject)
            if response?.code == "0"{
                
            }else{
                
            }
        }) {(_ msg: String) -> Void in
        }
    }
    
    //MARK:退出登录
    func requestForLogout() {
        let dic = NSDictionary()
        
        let post = RequestManager()
        post.postRequestManagerWithURL(urlStr: "api/app/agent/logout", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = Response.yy_model(withJSON: responseObject)
            if response?.code == "0"{
                
            }
        }) {(_ msg: String) -> Void in
        }
        self.clickConfirmButton()
    }
 
     override func vcRequestCode(requestCode: Int, resultCode: Int, result: AnyObject?) {
        if requestCode == 0 {
            if resultCode == -1 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: callBack), object: "1")
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: callBack), object: "-1")
            }
        }
    }
    
    //MARK:客服 注册appKey
    func clickAction () {
        if isFirstClick == false {
            return
        }
        isFirstClick = false
        indicatorView.startAnimating()
        QMConnect.registerSDKWithAppKey("8c8e98c0-8266-11e7-bbc4-cbe34b24d083", userName: "2222", userId: "32322")
    }
    
    //MARK:登陆成功
    func loginSuccess(sender:NSNotification) {
        if isPushed == true {
            return
        }
        self.getPeers()
    }
    
    //MARK:登录失败
    func loginFaile(sender:NSNotification) {
        isFirstClick = true
        indicatorView.stopAnimating()
    }
    
    func getPeers() {
        QMConnect.sdkGetPeers({ (peerArray) in
            DispatchQueue.main.async(execute: {() -> Void in
                let peers = peerArray
                self.indicatorView.stopAnimating()
                if peers.count == 1 && peers.count != 0 {
                    self.showChatRoomViewController(peerId: "2222")
                }else{
                    self.showPeersWithAlert(prres: peers)
                }
                self.isFirstClick = true
            })
        }){
            DispatchQueue.main.async(execute: {() -> Void in
                self.indicatorView.stopAnimating()
                self.isFirstClick = true
            })
        }
    }
    
    func showPeersWithAlert(prres:NSArray) {
        
    }
    
    func showChatRoomViewController(peerId:NSString) {
        let _chatRoomViewController = QMChatRoomViewController.init()
        _chatRoomViewController.peerId = peerId as String!
        _chatRoomViewController.isPush = false
        self.navigationController?.pushViewController(_chatRoomViewController, animated: true)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


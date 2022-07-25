//
//  WelcomeViewController.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/9/4.
//  Copyright © 2017年 刘浩. All rights reserved.
//热更新

import UIKit

class WelcomeViewController: BaseViewController,URLSessionDownloadDelegate {
    
    let user = UserDefaults.standard
    let label = UILabel()
    
    private lazy var session:URLSession = {
        //只执行一次
        let config = URLSessionConfiguration.default
        let currentSession = URLSession(configuration: config, delegate: self ,
                                        delegateQueue: nil)
        return currentSession
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statuseBarStyle()
        let imageView = UIImageView.init(frame: CGRect(x:0,y:0,width:WIDTH,height:HEIGHT))
        imageView.image = UIImage.init(named: "welcome")
        self.view.addSubview(imageView)
        self.requestForGetHotUpdateInfo()
        
        label.frame =  CGRect(x:10,y:HEIGHT-50,width:WIDTH-20,height:50)
        label.textColor = COLOR_TEXT_DARK
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "正在请求资源..."
        self.view.addSubview(label)
    }
    
    //MARK:热更新请求
    func requestForGetHotUpdateInfo() {
        var dic = NSDictionary()
        dic = ["id":911]
        
        let post = RequestManager()
        post.postLogInRequestManagerWithURL(urlStr: "api/app/common/GetHotUpdateInfo", dic: dic as NSDictionary, success: {(_ responseObject: Any) -> Void in
            let response = GetHotUpdateInfoResponse.yy_model(withJSON: responseObject)
            if (response?.code == "0"){
                if ((self.user.string(forKey: "Jsversion")) == response?.data.version){
                    self.jump()
                }else{
                    if((response?.data.path.characters.count)! > 0){
                        self.user.set(response?.data.version, forKey: "Jsversion")
                        self.sessionSeniorDownload(url: (response?.data.path)!)
                    }
                }
            }else{
                self.jump()
            }
        }) {(_ msg: String) -> Void in
            print(msg)
            self.jump()
        }
    }
    
    //MARK:下载文件
    func sessionSeniorDownload(url:String){
        //下载地址
        let url = URL(string: url)
        //请求
        let request = URLRequest(url: url!)
        //下载任务
        let downloadTask = session.downloadTask(with: request)
        //使用resume方法启动任务
        downloadTask.resume()
    }
    
    //MARK:下载代理方法，下载结束
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        
        let fileManager = FileManager()
        let pathDocuments:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let createPath: String = "\(pathDocuments)/lhjs.data"
        if fileManager.fileExists(atPath: createPath) {
            //文件夹存在
            //NSLog(@"文件夹存在");
        }else{
            //文件夹不存在
            //NSLog(@"文件夹不存在");
            //创建路径
            try? fileManager.createDirectory(atPath: createPath, withIntermediateDirectories: true, attributes: nil)
        }
        self.deleteFile()
        
        //下载结束
        print("下载结束")
        
        //输出下载文件原来的存放目录
        print("location:\(location)")
        //location位置转换
        let locationPath = location.path
        //拷贝到用户目录
        let documnets:String = createPath + "/index.ios.jsbundle"
        //创建文件管理器
        let fileManagers = FileManager.default
        try! fileManagers.moveItem(atPath: locationPath, toPath: documnets)
        print("new location:\(documnets)")
        
        self.jump()
    }
    
    //MARK:下载代理方法，监听下载进度
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        //获取进度
        let written:CGFloat = (CGFloat)(totalBytesWritten)
        let total:CGFloat = (CGFloat)(totalBytesExpectedToWrite)
        let pro:CGFloat = written/total
        OperationQueue.main.addOperation({() -> Void in
            self.label.text = "正在更新资源:" + String(format: "%.2f", pro*100) + "%"
        })
        print("下载进度：\(pro)")
    }
    
    //下载代理方法，下载偏移
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        //下载偏移，主要用于暂停续传
    }

    func deleteFile() {
        let fileManager = FileManager.default
        let pathDocuments: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let createPath: String = "\(pathDocuments)/lhjs.data"
        //文件名
        let uniquePath: String = "\(createPath)/index.ios.jsbundle"
        let blHave: Bool = FileManager.default.fileExists(atPath: uniquePath)
        if(!blHave){
            return
        }else{
            try? fileManager.removeItem(atPath: uniquePath)
        }
    }

    func jump() {
        let navRoot = ViewController()
        let navVC = UINavigationController(rootViewController: navRoot as UIViewController)
        self.view.window?.rootViewController = navVC
    }
    
    override func statuseBarStyle() {
        let mgr = AFNetworkReachabilityManager.shared()
        mgr.setReachabilityStatusChange { (status:AFNetworkReachabilityStatus) in
            if(status.rawValue == -1){
                print("未知网络")
            }else if(status.rawValue == 0){
                print("没有网络（断网）")
                self.jump()
            }else if(status.rawValue == 1){
                print("手机自带网络")
            }else if(status.rawValue == 2){
                print("WIFI")
            }
        }
        mgr.startMonitoring()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
//  SwiftConstant.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/9/1.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

public let WIDTH = UIScreen.main.applicationFrame.size.width
public let HEIGHT = UIScreen.main.applicationFrame.size.height
public let boxWidth = (WIDTH - 70) / 6

/*****************************************************************************************************/
public let HOST_URL  = "https://communication-service-v1-ncgzzf.gznb.com/"        //AppStore Prd生产
public let HOST_URLAdd = "https://filein-dev4.gznb.com/"                            //AppStore Prd生产文件上传
public let HOST_PUSH_URL = "http://api-push.gznb.com/"                               //App Store Prd推送
/*****************************************************************************************************/
//public let HOST_URL = "http://gzzs-api-pre.gznb.com/"                                   // pre开发环境
//public let HOST_URLAdd = "http://10.66.150.140:7100/"                                   //文件上传pre服务器
//public let HOST_PUSH_URL = "http://api-push-pre.gznb.com/"                               //推送pre
/*****************************************************************************************************/
//public let HOST_URL = "http://gzzf.gznb.qa:5001/"                                   //负载均衡test
//public let HOST_URLAdd = "http://10.66.30.66:7100/"                                   //文件上传test服务器
//public let HOST_PUSH_URL = "http://api-push-qa.gznb.com/"                               //推送测试
/***************************************************************************************************/

//let host :String = UserDefaults.standard.object(forKey: "host") as! String
//let hostUrl :NSDictionary = Bundle.main.infoDictionary?[host] as! NSDictionary
//public let HOST_URL : String = hostUrl["HOST_URL"]as! String                            //负载均衡test
//public let HOST_URLAdd : String = hostUrl["HOST_URLAdd"] as! String                     //负载均衡test
//public let HOST_PUSH_URL : String = hostUrl["HOST_PUSH_URL"]as! String                  //负载均衡test

public let COLOR_WHITE      = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
public let COLOR_GREY       = UIColor.init(red: 165.0/255.0, green: 165.0/255.0, blue: 165.0/255.0, alpha: 1)
public let COLOR_BLUE       = UIColor.init(red: 35.0/255.0, green: 164.0/255.0, blue: 264.0/255.0, alpha: 1)
public let COLOR_RED_V2     = UIColor.init(red: 235.0/255.0, green: 85.0/255.0, blue: 68.0/255.0, alpha: 1)
public let COLOR_BACKGROUND = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
public let COLOR_WINDOW     = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.4)
public let COLOR_LINE_LIGHTGRAY = UIColor.init(red: 134.0/255.0, green: 134.0/255.0, blue: 134.0/255.0, alpha: 1)
public let COLOR_LINE_GRAY  = UIColor.init(red: 225.0/255.0, green: 226.0/255.0, blue: 227.0/255.0, alpha: 1)
public let COLOR_TEXT_DARK  = UIColor.init(red: 65.0/255.0, green: 65.0/255.0, blue: 65.0/255.0, alpha: 1)
public let COLOR_TEXT_GREY  = UIColor.init(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
public let COLOR_LINE       = UIColor.init(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 1)
public let COLOR_BLACK      = UIColor.init(red: 37.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 1)
public let COLOR_GREEN      = UIColor.init(red: 104.0/255.0, green: 199.0/255.0, blue: 162.0/255.0, alpha: 1)

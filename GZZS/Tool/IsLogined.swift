//
//  IsLogined.swift
//  swiftLiu
//
//  Created by LiuHao on 2017/9/5.
//  Copyright © 2017年 刘浩. All rights reserved.
//

import UIKit

class IsLogined: NSObject {
    func isLogined() -> Bool {
        let user = UserDefaults.standard
        let userId = user.string(forKey: "userId")
        if((userId != nil && userId != "")){
            return true
        }
        return false
    }
    
    func isHasPwd() -> Bool {
        let user = UserDefaults.standard
        let hasPwd = user.string(forKey: "hasPwd")
        if (hasPwd == "YES") {
            return true
        }else if(hasPwd == "NO"){
            return false
        }
        return false
    }
}

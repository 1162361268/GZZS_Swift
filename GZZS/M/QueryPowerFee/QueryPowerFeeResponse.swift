//
//  QueryPowerFee.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/6.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class QueryPowerFeeResponse: NSObject {
    var code = NSString()
    var msg = String()
    var data = NSArray()
    
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["data": QueryPowerFeeList.self]
    }
    
}

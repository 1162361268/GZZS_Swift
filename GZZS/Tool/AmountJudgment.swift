//
//  AmountJudgment.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/6.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class AmountJudgment: NSObject {
    
    
    /// 金额判断
    ///
    /// - Parameters:
    ///   - money: 已输入的
    ///   - string: 正在输入的
    ///   - range: 位数
    /// - Returns: Bool
    func judgment(money:String,string:String,range:NSRange) -> Bool {
        
        let newString = (money as NSString).replacingCharacters(in: range, with: string)
        let expression = "^([0-9]{0,7})((\\.)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        return numberOfMatches != 0
    }
}

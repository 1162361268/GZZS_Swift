//
//  Loading.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/6.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class Loading: NSObject {
    
    func loading() -> Array<UIImage> {
        var images = Array<UIImage>()
        
        for i in 1...31 {
            
            let patch =  Bundle.main.path(forResource: "load_\(i)@2x.png", ofType: nil, inDirectory: nil)
            let image = UIImage(contentsOfFile: patch!)
            images.append(image!)
            
        }
        return images
    }
}

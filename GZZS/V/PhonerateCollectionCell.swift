//
//  PhonerateCollectionCell.swift
//  GZZS
//
//  Created by LiuHao on 2017/9/7.
//  Copyright © 2017年 云南省国有资本运营商城管理有限公司. All rights reserved.
//

import UIKit

class PhonerateCollectionCell: UICollectionViewCell {
    var amountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        amountLabel = UILabel.init(frame: self.bounds)
        self.addSubview(amountLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  XSpaceCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XSpaceCell: SNBaseTableViewCell {

    var styleColor : UIColor = .clear{
        didSet{
            backgroundColor = styleColor
            contentView.backgroundColor = styleColor
        }
    }
    
    override func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        hidLine()
    }

}

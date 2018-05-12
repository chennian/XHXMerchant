//
//  XGoodCateCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodCateCell: SNBaseTableViewCell {
    var models :GoodCateModel?{
        didSet{
            guard let cellModel = models else {
                return
            }
            cateLable.text = cellModel.category_name
        }
    }
    
    let cateLable = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.text = "衣服"
    }
    
    override func setupView() {
        contentView.addSubview(cateLable)
        hidLine()
        cateLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
    }
}

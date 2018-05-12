//
//  XGoodCateSearchListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodCateSearchListCell: SNBaseTableViewCell {
    
    var models :GoodCateSearchModel?{
        didSet{
            guard let cellModel = models else {
                return
            }
            cateLable.text = cellModel.cate
            numLable.text = "共\(cellModel.num)件商品"
        }
    }
    
    let cateLable = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.text = "衣服"
    }
    
    let numLable = UILabel().then{
        $0.textColor = Color(0x8e8e8e)
        $0.font = Font(27)
        $0.text = "共2件商品"
    }
    
    override func setupView() {
        contentView.addSubview(cateLable)
        contentView.addSubview(numLable)

        hidLine()
        cateLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        numLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
        }
    }
}

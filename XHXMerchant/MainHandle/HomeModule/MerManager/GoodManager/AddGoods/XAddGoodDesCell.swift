//
//  XAddGoodDesCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddGoodDesCell:SNBaseTableViewCell {
    
    private let descriptionLabel = UILabel().then{
        $0.text = "商品描述"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var descriptionText = SLTextView().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入此商品的描述"
        $0.placeholderColor = Color(0xa3a2a2)
    }
    
    override func setupView() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionText)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(26)
        }
        descriptionText.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-20)
            make.top.equalTo(descriptionLabel.snp.bottom).snOffset(30)
            make.height.snEqualTo(180)
        }
        
    }
    
}

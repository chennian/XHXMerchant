//
//  XListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XListCell: SNBaseTableViewCell {
    
    var lable = UILabel().then{
        $0.text = "收款码"
        $0.textColor = Color(0x238822)
        $0.font = Font(30)
    }
    
    var button = UIButton().then{
        $0.setBackgroundImage(UIImage(named: ""), for: UIControlState.normal)
        $0.backgroundColor = Color(0x238822)
    }
    
    override func setupView() {
        contentView.addSubview(lable)
        contentView.addSubview(button)
        
        lable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.center.equalToSuperview()
        }
        button.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
            make.height.width.snEqualTo(30)
        }
    }

}


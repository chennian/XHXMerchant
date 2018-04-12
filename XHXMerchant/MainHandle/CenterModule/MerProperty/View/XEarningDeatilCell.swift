//
//  EarningDeatilCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XEarningDeatilCell: SNBaseTableViewCell {
    
    var nameLable = UILabel().then{
        $0.text = "388.88"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var profit = UILabel().then{
        $0.text = "+ ￥388.88"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var des = UILabel().then{
        $0.text = "1234笔分润"
    }

    override func setupView() {
        contentView.addSubview(nameLable)
        contentView.addSubview(profit)
        contentView.addSubview(des)
        
        nameLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(20)
        }
        profit.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
        }
        des.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(nameLable.snp.bottom).snOffset(10)
        }
        
    }

}

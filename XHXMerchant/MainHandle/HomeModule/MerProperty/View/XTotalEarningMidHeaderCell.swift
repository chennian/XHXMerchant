//
//  XEarningDayMidHeaderCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/22.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningMidHeaderCell: SNBaseTableViewCell {
    var model:todayModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            todayLable.text = "今日收益    \(cellModel.money)"
        }
    }
    
    var img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "earnings_today")
    }
    
    var todayLable = UILabel().then{
        $0.text = "今日收益    3848.00"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }

    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(todayLable)
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.height.snEqualTo(35)
            make.width.snEqualTo(40)
        }
        todayLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.centerY.equalTo(img.snp.centerY)
        }

    }

}

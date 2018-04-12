//
//  XEarningDayDetailTCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XEarningDayDetailTCell: SNBaseTableViewCell {

    var img = UIImageView().then{
        $0.backgroundColor = .red
        $0.layer.cornerRadius = fit(35)
        $0.clipsToBounds = true
    }
    
    var nameLable = UILabel().then{
        $0.text = "木屋烧烤"
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    }
    
    var profit = UILabel().then{
        $0.text = "+ 0.99"
        $0.font = BoldFont(40)
        $0.textColor = Color(0x313131)
    }
    
    var des = UILabel().then{
        $0.font = Font(24)
        $0.text = "收款90笔"
        $0.textColor = Color(0x818181)
    }
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(nameLable)
        contentView.addSubview(profit)
        contentView.addSubview(des)

        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.height.width.snEqualTo(70)
            make.centerY.equalToSuperview()
        }
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(18)
            make.top.equalTo(img.snp.top)
        }
        profit.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-27)
            make.centerY.equalToSuperview()

        }
        des.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(18)
            make.top.equalTo(nameLable.snp.bottom).snOffset(17)
        }
        
    }

}

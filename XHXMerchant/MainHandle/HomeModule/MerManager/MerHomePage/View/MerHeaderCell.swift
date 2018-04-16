//
//  MerHeaderCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class MerHeaderCell: SNBaseTableViewCell {
    let backImg = UIImageView().then{
        $0.image = UIImage(named: "")
    }
    let view  = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let merName = UILabel().then{
        $0.font = BoldFont(44)
        $0.text = "木屋烧烤"
        $0.textColor = Color(0x313131)
    }
    let userNum = UILabel().then{
        $0.font = Font(24)
        $0.text = "会员数量:23232"
        $0.textColor = Color(0x48494d)
    }
    let staffNum = UILabel().then{
        $0.font = Font(24)
        $0.text = "员工数量:23232"
        $0.textColor = Color(0x48494d)
    }
    
    let merHeaderImg  = UIImageView().then{
        $0.backgroundColor = .clear
    }
    override func setupView() {
        contentView.addSubview(backImg)
        contentView.addSubview(view)
        view.addSubview(merName)
        view.addSubview(userNum)
        view.addSubview(staffNum)
        contentView.addSubview(merHeaderImg)
        
        backImg.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(240)
        }
        view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(backImg.snp.bottom)
        }
        merName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(70)
        }
        userNum.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(158)
            make.top.equalTo(merName.snp.bottom).snOffset(28)
        }
        staffNum.snp.makeConstraints { (make) in
            make.left.equalTo(userNum.snp.left).snOffset(259)
            make.top.equalTo(merName.snp.bottom).snOffset(28)
        }
        
        merHeaderImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(92)
            make.height.snEqualTo(190)
            make.width.snEqualTo(200)
        }

    }
}

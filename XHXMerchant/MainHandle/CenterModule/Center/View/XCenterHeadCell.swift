//
//  XCenterHeadCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XCenterHeadCell: SNBaseTableViewCell {
        
    var headImg = UIImageView().then{
        $0.backgroundColor = .red
        $0.layer.cornerRadius = fit(60)
        $0.layer.masksToBounds = true
    }
    var name = UILabel().then{
        $0.text = "姓名"
        $0.textColor = Color(0x238822)
        $0.font = Font(30)
    }
    var phone = UILabel().then{
        $0.text = "17603078066"
        $0.textColor = Color(0x238822)
        $0.font = Font(30)
    }
    
    var timeButton = TimerButton().then{
        $0.timeLength = 60
        $0.backgroundColor = Color(0x272424)

    }
    
    override func setupView() {
        contentView.addSubview(headImg)
        contentView.addSubview(name)
        contentView.addSubview(phone)
        contentView.addSubview(timeButton)
        
        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)

        headImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(60)
            make.top.equalToSuperview().snOffset(60)
            make.height.width.snEqualTo(120)
        }
        name.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).snOffset(30)
            make.top.equalTo(headImg.snp.top).snOffset(15)
        }
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).snOffset(30)
            make.bottom.equalTo(headImg.snp.bottom).snOffset(-15)
        }
        timeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(headImg.snp.centerY)
            make.width.snEqualTo(150)
            make.height.snEqualTo(40)
        }
    }

}

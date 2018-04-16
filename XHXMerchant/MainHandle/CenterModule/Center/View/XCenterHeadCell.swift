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
        $0.image = UIImage(named: "LBlogoIcon")
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = fit(60)
        $0.layer.masksToBounds = true
    }
    var name = UILabel().then{
        $0.text = "17603078066"
        $0.textColor = Color(0xffffff)
        $0.font = Font(30)
    }
    var phone = UILabel().then{
        $0.text = "服务商"
        $0.textColor = Color(0xffffff)
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
        
        self.backgroundColor = Color(0xff8518)
        
        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)

        timeButton.isHidden = true
        
        headImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(57)
            make.top.equalToSuperview().snOffset(24)
            make.height.width.snEqualTo(122)
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

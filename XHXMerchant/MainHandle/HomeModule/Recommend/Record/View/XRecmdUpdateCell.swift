//
//  XRecmdUpdateCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XRecmdUpdateCell: SNBaseTableViewCell {
    var img = UIImageView().then{
        $0.backgroundColor = .red
        $0.layer.cornerRadius = fit(35)
        $0.clipsToBounds = true
    }
    
    var lableClass = UILabel().then{
        $0.text = "我的等级：服务商"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var account = UILabel().then{
        $0.text = "用户账号：13632536667"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var updateType = UILabel().then{
        $0.font = Font(24)
        $0.text = "推荐时间:2018-01-11"
        $0.textColor = Color(0x313131)
    }
    
    var updateTime = UILabel().then{
        $0.font = Font(26)
        $0.text = "升级时间：2018-02-11 12：11：20"
        $0.textColor = Color(0x313131)
    }
    
    var status = UILabel().then{
        $0.font = Font(34)
        $0.text = "成功"
        $0.textColor = Color(0x313131)
    }
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(lableClass)
        contentView.addSubview(account)
        contentView.addSubview(updateType)
        contentView.addSubview(updateTime)
        contentView.addSubview(status)

        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(70)
        }
        lableClass.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.left.equalTo(img.snp.right).snOffset(25)
        }

        account.snp.makeConstraints { (make) in
            make.top.equalTo(lableClass.snp.bottom).snOffset(18)
            make.left.equalTo(img.snp.right).snOffset(25)
        }
        updateType.snp.makeConstraints { (make) in
            make.top.equalTo(account.snp.bottom).snOffset(18)
            make.left.equalTo(img.snp.right).snOffset(25)
        }
        updateTime.snp.makeConstraints { (make) in
            make.top.equalTo(updateType.snp.bottom).snOffset(18)
            make.left.equalTo(img.snp.right).snOffset(25)
        }
        status.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-29)
            make.centerY.equalTo(img.snp.centerY)
        }

    }

}

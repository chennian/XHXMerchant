//
//  XRecmdMerCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XRecmdMerCell: SNBaseTableViewCell {
    
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
    
    var principal = UILabel().then{
        $0.text = "负责人:尤泽清"
        $0.font = BoldFont(24)
        $0.textColor = Color(0x818181)
    }
    
    var recmdTime = UILabel().then{
        $0.font = Font(24)
        $0.text = "推荐时间:2018-01-11"
        $0.textColor = Color(0x818181)
    }
    
    var status = UILabel().then{
        $0.font = Font(34)
        $0.text = "成功"
        $0.textColor = Color(0x818181)
    }
    

    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(nameLable)
        contentView.addSubview(principal)
        contentView.addSubview(recmdTime)
        contentView.addSubview(status)
        
//        line.isHidden = true
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.height.width.snEqualTo(70)
        }
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalToSuperview().snOffset(30)
        }
        principal.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalTo(nameLable.snp.bottom).snOffset(17)
        }
        recmdTime.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalTo(principal.snp.bottom).snOffset(17)
        }
        
        status.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-29)
            make.centerY.equalTo(img.snp.centerY)
        }
    }

}

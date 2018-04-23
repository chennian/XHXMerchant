//
//  XRecmdMerCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XRecmdMerCell: SNBaseTableViewCell {
    
    var model:XRecmdMerModel?{
        didSet{
            guard let cellModel = model else {return}
            self.nameLable.text = cellModel.shopName
            self.principal.text = "负责人:\(cellModel.name)"
            self.recmdTime.text = "推荐时间:\(cellModel.add_time)"
            if cellModel.state == "1" {
                self.status.text = "审核中"
                self.status.textColor = Color(0x00bc54)
            }else if cellModel.state == "2"{
                self.status.text = "失败"
                self.status.textColor = Color(0xff0000)
            }else{
                self.status.text = "成功"
                self.status.textColor = Color(0x006cff)
            }
        }
    }
    
    
    var img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "earnings_merchant")
    }
    
    var nameLable = UILabel().then{
        $0.text = "木屋烧烤"
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    }
    
    var principal = UILabel().then{
        $0.text = "负责人:尤泽清"
        $0.font = Font(24)
        $0.textColor = Color(0x313131)
    }
    
    var recmdTime = UILabel().then{
        $0.font = Font(24)
        $0.text = "推荐时间:2018-01-11"
        $0.textColor = Color(0x313131)
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

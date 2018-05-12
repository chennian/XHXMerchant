//
//  XRecmdUpdateCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XRecmdUpdateCell: SNBaseTableViewCell {
    
    var model : XRecmdUserModel?{
        didSet{
            guard let cellModel = model else {return}
            var currentString:String = ""
            if cellModel.current_role == "0" {
                currentString = "普通用户"
            }else if cellModel.current_role == "1"{
                currentString = "商家"
            }else{
                currentString = "服务商"
            }
            
            var upgrateString:String = ""
            if cellModel.upgrate_role == "1"{
                upgrateString = "服务商"
            }else{
                upgrateString = "运营商"
            }
            self.lableClass.text = "我的等级:\(cellModel.parent_role)"
            self.account.text = "用户账号:\(cellModel.phone)"
            self.updateTime.text = "升级时间:\(cellModel.add_time)"
            self.updateType.text = "升级方式:\(currentString)-\(upgrateString)"
            if cellModel.status == "1" {
                self.status.text = "审核中"
                self.status.textColor = Color(0x00bc54)
            }else if cellModel.status == "2"{
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
        $0.image = UIImage(named: "LBlogoIcon")
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
        $0.font = Font(26)
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

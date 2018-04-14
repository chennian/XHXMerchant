//
//  XOperatorTopCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XOperatorTopCell:SNBaseTableViewCell {
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }

    var rcmdRole = UILabel().then{
        $0.text = "推荐等级     运营商"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var accountLable = UILabel().then{
        $0.text = "用户账号"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var accountField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入被推荐人的手机号"
    }
    
    var codeLable = UILabel().then{
        $0.text = "短信验证"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    var codeLableField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入验证码"
    }
    
    var timeButton = TimerButton().then{
        $0.timeLength = 60
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    override func setupView() {
        
        contentView.addSubview(rcmdRole)
        contentView.addSubview(accountLable)
        contentView.addSubview(accountField)
        contentView.addSubview(codeLable)
        contentView.addSubview(codeLableField)
        contentView.addSubview(timeButton)
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        
        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)
        
        line1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalToSuperview().snOffset(90)

        }
        line2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line1.snp.bottom).snOffset(90)
        }
        
        rcmdRole.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line1.snp.top).snOffset(-30)
        }
        
        accountLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line2.snp.top).snOffset(-30)
        }
        
        accountField.snp.makeConstraints { (make) in
            make.left.equalTo(accountLable.snp.right).snOffset(30)
            make.centerY.equalTo(accountLable.snp.centerY)
            make.width.snEqualTo(380)
        }
        
        codeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(30)
        }
        
        codeLableField.snp.makeConstraints { (make) in
            make.left.equalTo(codeLable.snp.right).snOffset(30)
            make.centerY.equalTo(codeLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        
        timeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(codeLableField.snp.centerY)
            make.width.snEqualTo(180)
            make.height.snEqualTo(65)
        }

    }
    
}

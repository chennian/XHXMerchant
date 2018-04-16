//
//  XBasicInfoFieldCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XBasicInfoFieldCell: SNBaseTableViewCell {
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line3 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line4 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }

    var registName = UILabel().then{
        $0.text = "注册手机号"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var registNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "该手机号将用来登录商家版"
    }
    var principal = UILabel().then{
        $0.text = "负责人信息"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var principalField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入负责人姓名"
    }
    
    var principalPhone = UILabel().then{
        $0.text = "负责人手机号"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)

    }
    var principalPhoneField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入手机号码"
    }
    
    var idCard = UILabel().then{
        $0.text = "身份证号码"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var idCardField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "400000000000"
    }
    
    var validity = UILabel().then{
        $0.text = "身份证有效期"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var validityField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "有效日期格式,如:20180420"
    }
    
    let view = UIView().then{
        $0.backgroundColor = Color(0xf5f5f5)
    }
    let notice = UILabel().then{
        $0.text = "注：负责人姓名需与营业执照法人姓名一致"
        $0.font = Font(24)
        $0.textColor = Color(0x9f9f9f)
        
    }
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        
        contentView.addSubview(registName)
        contentView.addSubview(registNameField)
        contentView.addSubview(principal)
        contentView.addSubview(principalField)
        contentView.addSubview(principalPhone)
        contentView.addSubview(principalPhoneField)
        contentView.addSubview(idCard)
        contentView.addSubview(idCardField)
        contentView.addSubview(validity)
        contentView.addSubview(validityField)
        contentView.addSubview(view)
        view.addSubview(notice)


        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalToSuperview().snOffset(90)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line1.snp.bottom).snOffset(90)
        }
        line3.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line2.snp.bottom).snOffset(90)
        }
        line4.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line3.snp.bottom).snOffset(90)
        }

        registName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(195)
        }
        
        registNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(registName.snp.right).offset(10)
            make.centerY.equalTo(registName.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        principal.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(30)
            make.width.snEqualTo(195)
        }
        
        principalField.snp.makeConstraints { (make) in
            make.left.snEqualTo(principal.snp.right).offset(10)
            make.centerY.equalTo(principal.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        principalPhone.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(30)
            make.width.snEqualTo(195)
        }
        
        principalPhoneField.snp.makeConstraints { (make) in
            make.left.snEqualTo(principalPhone.snp.right).offset(10)
            make.centerY.equalTo(principalPhone.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        idCard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line3.snp.bottom).snOffset(30)
            make.width.snEqualTo(195)
        }
        
        idCardField.snp.makeConstraints { (make) in
            make.left.snEqualTo(idCard.snp.right).offset(10)
            make.centerY.equalTo(idCard.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        validity.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line4.snp.bottom).snOffset(30)
            make.width.snEqualTo(195)
        }
        
        validityField.snp.makeConstraints { (make) in
            make.left.snEqualTo(validity.snp.right).offset(10)
            make.centerY.equalTo(validity.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(validity.snp.bottom).snOffset(32)
            make.height.snEqualTo(77)
        }

        notice.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(28)
            make.top.equalToSuperview().snOffset(16)
        }
    }
}

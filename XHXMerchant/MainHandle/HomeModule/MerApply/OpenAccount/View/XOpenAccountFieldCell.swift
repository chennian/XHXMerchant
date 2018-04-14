//
//  XOpenAccountFieldCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XOpenAccountFieldCell: SNBaseTableViewCell {
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
    private var line5 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }

    
    var openBankAccount = UILabel().then{
        $0.text = "对公银行账户"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var openBankAccountField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入对公银行账号"
    }
    var openBank = UILabel().then{
        $0.text = "开户行"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var openBankField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择开户行"
    }
    
    var openBankAddress = UILabel().then{
        $0.text = "开户行所在地"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var openBankAddressField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择开户行所在地"
    }
    
    var branchnName = UILabel().then{
        $0.text = "支行名称"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var branchnNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入支行名称"
    }
    
    var openbankName = UILabel().then{
        $0.text = "银行开户名"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var openbankNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入开户行名称"
    }
    
    var leftPhone = UILabel().then{
        $0.text = "预留手机号"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var leftPhoneField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入预留手机号"
    }

    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        contentView.addSubview(line5)
        
        contentView.addSubview(openBankAccount)
        contentView.addSubview(openBankAccountField)
        contentView.addSubview(openBank)
        contentView.addSubview(openBankField)
        contentView.addSubview(openBankAddress)
        contentView.addSubview(openBankAddressField)
        contentView.addSubview(branchnName)
        contentView.addSubview(branchnNameField)
        contentView.addSubview(openbankName)
        contentView.addSubview(openbankNameField)
        contentView.addSubview(leftPhone)
        contentView.addSubview(leftPhoneField)

        
        
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
        line5.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line4.snp.bottom).snOffset(90)
        }

        
        openBankAccount.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(200)
        }
        
        openBankAccountField.snp.makeConstraints { (make) in
            make.left.snEqualTo(openBankAccount.snp.right).offset(10)
            make.centerY.equalTo(openBankAccount.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        openBank.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        openBankField.snp.makeConstraints { (make) in
            make.left.snEqualTo(openBank.snp.right).offset(10)
            make.centerY.equalTo(openBank.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        openBankAddress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        openBankAddressField.snp.makeConstraints { (make) in
            make.left.snEqualTo(openBankAddress.snp.right).offset(10)
            make.centerY.equalTo(openBankAddress.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        branchnName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line3.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        branchnNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(branchnName.snp.right).offset(10)
            make.centerY.equalTo(branchnName.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        openbankName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line4.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        openbankNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(openbankName.snp.right).offset(10)
            make.centerY.equalTo(openbankName.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        leftPhone.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line5.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        leftPhoneField.snp.makeConstraints { (make) in
            make.left.snEqualTo(leftPhone.snp.right).offset(10)
            make.centerY.equalTo(leftPhone.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
    }
}

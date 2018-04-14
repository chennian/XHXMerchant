//
//  XPrivateAccountFieldCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XPrivateAccountFieldCell: SNBaseTableViewCell {
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
    private var line6 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    
    
    var privateBankAccount = UILabel().then{
        $0.text = "对公银行账户"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var privateBankAccountField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入对公银行账号"
    }
    var privateBank = UILabel().then{
        $0.text = "开户行"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var privateBankField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择开户行"
    }
    
    var privateBankAddress = UILabel().then{
        $0.text = "开户行所在地"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var privateBankAddressField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择开户行所在地"
    }
    
    var branchName = UILabel().then{
        $0.text = "支行名称"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var branchNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入支行名称"
    }
    
    var privatebankName = UILabel().then{
        $0.text = "银行开户名"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var privatebankNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入开户行名称"
    }
    
    var leftMobile = UILabel().then{
        $0.text = "预留手机号"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var leftMobileField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入预留手机号"
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
        $0.placeholder = "请输入6位验证码"
    }
    
    var timeButton = TimerButton().then{
        $0.timeLength = 60
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
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
        contentView.addSubview(line5)
        contentView.addSubview(line6)

        contentView.addSubview(privateBankAccount)
        contentView.addSubview(privateBankAccountField)
        contentView.addSubview(privateBank)
        contentView.addSubview(privateBankField)
        contentView.addSubview(privateBankAddress)
        contentView.addSubview(privateBankAddressField)
        contentView.addSubview(branchName)
        contentView.addSubview(branchNameField)
        contentView.addSubview(privatebankName)
        contentView.addSubview(privatebankNameField)
        contentView.addSubview(leftMobile)
        contentView.addSubview(leftMobileField)
        contentView.addSubview(codeLable)
        contentView.addSubview(codeLableField)
        contentView.addSubview(timeButton)
        contentView.addSubview(view)
        view.addSubview(notice)

        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)

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
        line6.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line5.snp.bottom).snOffset(90)
        }
        
        
        privateBankAccount.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(200)
        }
        
        privateBankAccountField.snp.makeConstraints { (make) in
            make.left.snEqualTo(privateBankAccount.snp.right).offset(10)
            make.centerY.equalTo(privateBankAccount.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        privateBank.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        privateBankField.snp.makeConstraints { (make) in
            make.left.snEqualTo(privateBank.snp.right).offset(10)
            make.centerY.equalTo(privateBank.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        privateBankAddress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        privateBankAddressField.snp.makeConstraints { (make) in
            make.left.snEqualTo(privateBankAddress.snp.right).offset(10)
            make.centerY.equalTo(privateBankAddress.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        branchName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line3.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        branchNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(branchName.snp.right).offset(10)
            make.centerY.equalTo(branchName.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        privatebankName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line4.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        privatebankNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(privatebankName.snp.right).offset(10)
            make.centerY.equalTo(privatebankName.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        leftMobile.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line5.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        leftMobileField.snp.makeConstraints { (make) in
            make.left.snEqualTo(leftMobile.snp.right).offset(10)
            make.centerY.equalTo(leftMobile.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        codeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line6.snp.bottom).snOffset(30)
            make.width.snEqualTo(200)
        }
        
        codeLableField.snp.makeConstraints { (make) in
            make.left.snEqualTo(codeLable.snp.right).offset(10)
            make.centerY.equalTo(codeLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        timeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(codeLableField.snp.centerY)
            make.right.equalToSuperview().snOffset(-30)
            make.width.snEqualTo(180)
            make.height.snEqualTo(60)
        }
        view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(codeLable.snp.bottom).snOffset(32)
            make.height.snEqualTo(77)
        }
        
        notice.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(28)
            make.top.equalToSuperview().snOffset(16)
        }
        
    }
}

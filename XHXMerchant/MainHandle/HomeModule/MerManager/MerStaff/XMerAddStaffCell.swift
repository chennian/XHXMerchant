//
//  XMerAddStaffCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerAddStaffCell: SNBaseTableViewCell {
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line3 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    
    
    var staffName = UILabel().then{
        $0.text = "员工名字"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var staffNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入员工名字"
    }
    var staffAccount = UILabel().then{
        $0.text = "员工账号"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var staffAccountField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入员工账号"
    }
    
    var staffAccountDes = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var password = UILabel().then{
        $0.text = "密码"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var passwordField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入密码"
        $0.isSecureTextEntry = true
    }
    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        
        contentView.addSubview(staffName)
        contentView.addSubview(staffNameField)
        contentView.addSubview(staffAccount)
        contentView.addSubview(staffAccountField)
        contentView.addSubview(staffAccountDes)

        contentView.addSubview(password)
        contentView.addSubview(passwordField)
        
        line.isHidden = true
        
        
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
        
        staffName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line1.snp.top).snOffset(-30)
            make.width.snEqualTo(140)
        }
        staffNameField.snp.makeConstraints { (make) in
            make.left.equalTo(staffName.snp.right).snOffset(20)
            make.centerY.equalTo(staffName.snp.centerY)
            make.right.equalToSuperview().snOffset(-80)
        }
        
        staffAccount.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line2.snp.top).snOffset(-30)
            make.width.snEqualTo(140)
        }
        staffAccountField.snp.makeConstraints { (make) in
            make.left.equalTo(staffAccount.snp.right).snOffset(20)
            make.centerY.equalTo(staffAccount.snp.centerY)
            make.width.snEqualTo(235)
        }
        
        staffAccountDes.snp.makeConstraints { (make) in
            make.centerY.equalTo(staffAccountField.snp.centerY)
            make.left.equalTo(staffAccountField.snp.right).snOffset(10)
        }
        password.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(30)
            make.width.snEqualTo(140)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.left.equalTo(password.snp.right).snOffset(20)
            make.centerY.equalTo(password.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
    }
    
}

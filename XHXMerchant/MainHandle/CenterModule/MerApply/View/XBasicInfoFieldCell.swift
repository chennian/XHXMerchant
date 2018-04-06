//
//  XBasicInfoFieldCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XBasicInfoFieldCell: SNBaseTableViewCell {
    private let line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line3 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line4 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line5 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line6 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    var accountName = UILabel().then{
        $0.text = "账号:"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .right
    }
    var accountNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "张三"
    }
    var legalName = UILabel().then{
        $0.text = "法人姓名:"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .right

    }
    var legalNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "李四"
    }
    
    private let idCard = UILabel().then{
        $0.text = "身份证号:"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .right

    }
    var idCardTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "42011720029392328273728"
    }
    
    var emergencyContact = UILabel().then{
        $0.text = "紧急联系人:"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .right
        
    }
    var emergencyContactField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "王五"
    }
    
    var emergencyContactPhone = UILabel().then{
        $0.text = "紧急联系人电话:"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .right
        
    }
    var emergencyContactPhoneField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "王五"
    }

    var email = UILabel().then{
        $0.text = "邮箱:"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .right
        
    }
    var emailField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "617356692@qq.com"
    }

    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        contentView.addSubview(line5)
        contentView.addSubview(line6)
        
        contentView.addSubview(accountName)
        contentView.addSubview(accountNameField)
        contentView.addSubview(legalName)
        contentView.addSubview(legalNameField)
        contentView.addSubview(idCard)
        contentView.addSubview(idCardTextField)
        contentView.addSubview(emergencyContact)
        contentView.addSubview(emergencyContactField)
        contentView.addSubview(emergencyContactPhone)
        contentView.addSubview(emergencyContactPhoneField)
        contentView.addSubview(email)
        contentView.addSubview(emailField)

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
        
        accountName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(35)
            make.width.snEqualTo(195)
        }
        
        accountNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(accountName.snp.right).offset(10)
            make.centerY.equalTo(accountName.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        legalName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(35)
            make.width.snEqualTo(195)
        }
        
        legalNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(legalName.snp.right).offset(10)
            make.centerY.equalTo(legalName.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        idCard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(35)
            make.width.snEqualTo(195)
        }
        
        idCardTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(idCard.snp.right).offset(10)
            make.centerY.equalTo(idCard.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        emergencyContact.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line3.snp.bottom).snOffset(35)
            make.width.snEqualTo(195)
        }
        
        emergencyContactField.snp.makeConstraints { (make) in
            make.left.snEqualTo(emergencyContact.snp.right).offset(10)
            make.centerY.equalTo(emergencyContact.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        emergencyContactPhone.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line4.snp.bottom).snOffset(35)
            make.width.snEqualTo(195)
        }
        
        emergencyContactPhoneField.snp.makeConstraints { (make) in
            make.left.snEqualTo(emergencyContactPhone.snp.right).offset(10)
            make.centerY.equalTo(emergencyContactPhone.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        email.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line5.snp.bottom).snOffset(35)
            make.width.snEqualTo(195)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.left.snEqualTo(email.snp.right).offset(10)
            make.centerY.equalTo(email.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }

        
    }


}

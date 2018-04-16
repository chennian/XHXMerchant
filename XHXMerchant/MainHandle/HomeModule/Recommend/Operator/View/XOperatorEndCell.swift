//
//  XOperatorEndCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XOperatorEndCell: SNBaseTableViewCell {
    
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
    
    var realName = UILabel().then{
        $0.text = "真实姓名"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var realNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入真实姓名"
    }
    var IDNum = UILabel().then{
        $0.text = "身份证号"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var IDNumField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入身份证号"
    }
    var bankNumLable = UILabel().then{
        $0.text = "银行卡号"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var bankNumField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入银行卡号"
    }
    
    var cardbankLable = UILabel().then{
        $0.text = "开卡银行"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    var cardbankField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入银行名称"
    }
    var branchLable = UILabel().then{
        $0.text = "开户支行"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    var branchLableField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入开户支行"
    }
    

    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        
        contentView.addSubview(realName)
        contentView.addSubview(realNameField)
        contentView.addSubview(IDNum)
        contentView.addSubview(IDNumField)
        contentView.addSubview(bankNumLable)
        contentView.addSubview(bankNumField)
        contentView.addSubview(cardbankLable)
        contentView.addSubview(cardbankField)
        contentView.addSubview(branchLable)
        contentView.addSubview(branchLableField)
        
        
        
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
        line3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line2.snp.bottom).snOffset(90)
        }
        line4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line3.snp.bottom).snOffset(90)
        }
        
        realName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line1.snp.top).snOffset(-30)
        }
        realNameField.snp.makeConstraints { (make) in
            make.left.equalTo(realName.snp.right).snOffset(32)
            make.centerY.equalTo(realName.snp.centerY)
            make.width.snEqualTo(300)
        }
        
        IDNum.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line2.snp.top).snOffset(-30)
        }
        IDNumField.snp.makeConstraints { (make) in
            make.left.equalTo(IDNum.snp.right).snOffset(32)
            make.centerY.equalTo(IDNum.snp.centerY)
            make.width.snEqualTo(300)
        }
        bankNumLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line3.snp.top).snOffset(-30)
        }
        
        bankNumField.snp.makeConstraints { (make) in
            make.left.equalTo(bankNumLable.snp.right).snOffset(32)
            make.centerY.equalTo(bankNumLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        
        cardbankLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line4.snp.top).snOffset(-30)
        }
        
        cardbankField.snp.makeConstraints { (make) in
            make.left.equalTo(cardbankLable.snp.right).snOffset(32)
            make.centerY.equalTo(cardbankLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        
        branchLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line4.snp.bottom).snOffset(30)
        }
        
        branchLableField.snp.makeConstraints { (make) in
            make.left.equalTo(branchLable.snp.right).snOffset(32)
            make.centerY.equalTo(branchLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        
    }
    
}

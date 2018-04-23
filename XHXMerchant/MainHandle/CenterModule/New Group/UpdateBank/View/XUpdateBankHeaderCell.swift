//
//  XUpdateBankHeaderCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XUpdateBankHeaderCell: SNBaseTableViewCell {

    var notice = UILabel().then{
        $0.text = "请绑定持卡人本人的银行卡"
        $0.font = Font(28)
        $0.textColor = Color(0x626262)
    }
    
    let view = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    var phoneLable = UILabel().then{
        $0.text = "手机号码"
        $0.font = Font(30)
        $0.textColor = Color(0x626262)
    }
    var phoneLableField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入手机号码"
    }
    var cardholder = UILabel().then{
        $0.text = "持卡人"
        $0.font = Font(30)
        $0.textColor = Color(0x626262)
    }
    var cardholderField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入持卡人姓名"
    }
    
    var IDCard = UILabel().then{
        $0.text = "身份证"
        $0.font = Font(30)
        $0.textColor = Color(0x626262)
    }
    var IDCardField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入身份证号码"
    }
    
    let bankNumLable = UILabel().then{
        $0.text = "银行卡号"
        $0.font = Font(30)
        $0.textColor = Color(0x626262)
    }
    
    var bankNumField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入银行卡号"
    }
    
    let cardBank = UILabel().then{
        $0.text = "开卡银行"
        $0.font = Font(30)
        $0.textColor = Color(0x626262)
    }
    
    var cardBankField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入银行名称"
    }
    
    let cardBranchBank = UILabel().then{
        $0.text = "开户支行"
        $0.font = Font(30)
        $0.textColor = Color(0x626262)
    }
    
    var cardBranchBankField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入开户支行"
    }
    
    var codeLable = UILabel().then{
        $0.text = "短信验证"
        $0.textColor = Color(0x626262)
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
    override func setupView() {
        self.backgroundColor = Color(0xf5f5f5)
        contentView.addSubview(notice)
        contentView.addSubview(view)
        
        view.addSubview(line1)
        view.addSubview(line2)
        view.addSubview(line3)
        view.addSubview(line4)
        view.addSubview(line5)
        view.addSubview(line6)

        view.addSubview(phoneLable)
        view.addSubview(phoneLableField)
        view.addSubview(cardholder)
        view.addSubview(cardholderField)
        view.addSubview(IDCard)
        view.addSubview(IDCardField)
        view.addSubview(bankNumLable)
        view.addSubview(bankNumField)
        view.addSubview(cardBank)
        view.addSubview(cardBankField)
        view.addSubview(cardBranchBank)
        view.addSubview(cardBranchBankField)
        view.addSubview(codeLable)
        view.addSubview(codeLableField)
        view.addSubview(timeButton)
        
        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)

        
        notice.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(28)
            make.top.equalToSuperview().snOffset(34)
        }
        view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(80)
            make.height.snEqualTo(633)
        }
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
        line5.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line4.snp.bottom).snOffset(90)
        }
        line6.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line5.snp.bottom).snOffset(90)
        }

        phoneLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line1.snp.top).snOffset(-30)
            make.width.snEqualTo(125)
        }
        phoneLableField.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLable.snp.right).snOffset(55)
            make.centerY.equalTo(phoneLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        cardholder.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line2.snp.top).snOffset(-30)
            make.width.snEqualTo(120)
        }
        cardholderField.snp.makeConstraints { (make) in
            make.left.equalTo(cardholder.snp.right).snOffset(55)
            make.centerY.equalTo(cardholder.snp.centerY)
            make.width.snEqualTo(300)
        }
        IDCard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line3.snp.top).snOffset(-30)
            make.width.snEqualTo(120)
        }
        IDCardField.snp.makeConstraints { (make) in
            make.left.equalTo(IDCard.snp.right).snOffset(55)
            make.centerY.equalTo(IDCard.snp.centerY)
            make.width.snEqualTo(300)
        }
        bankNumLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line4.snp.top).snOffset(-30)
        }
        bankNumField.snp.makeConstraints { (make) in
            make.left.equalTo(bankNumLable.snp.right).snOffset(55)
            make.centerY.equalTo(bankNumLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        cardBank.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line5.snp.top).snOffset(-30)
        }
        cardBankField.snp.makeConstraints { (make) in
            make.left.equalTo(cardBank.snp.right).snOffset(55)
            make.centerY.equalTo(cardBank.snp.centerY)
            make.width.snEqualTo(300)
        }
        cardBranchBank.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line6.snp.top).snOffset(-30)
        }
        cardBranchBankField.snp.makeConstraints { (make) in
            make.left.equalTo(cardBranchBank.snp.right).snOffset(55)
            make.centerY.equalTo(cardBranchBank.snp.centerY)
            make.width.snEqualTo(300)
        }
        codeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line6.snp.bottom).snOffset(30)
        }
        codeLableField.snp.makeConstraints { (make) in
            make.left.equalTo(cardBranchBank.snp.right).snOffset(55)
            make.centerY.equalTo(codeLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        timeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(codeLableField.snp.centerY)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(60)
            make.width.snEqualTo(180)
        }
        
    }

   
}

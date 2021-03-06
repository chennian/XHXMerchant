//
//  LBAddSeckillFieldCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

import APJTextPickerView

class LBAddSeckillFieldCell: SNBaseTableViewCell {
    
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

    var titleLable = UILabel().then{
        $0.text = "标题"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var titleTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入卡卷标题"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    private let priceLable = UILabel().then{
        $0.text = "价格"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    private let priceUnitLable = UILabel().then{
        $0.text = "元"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var priceTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入价格"
        
    }
    
    private let countLable = UILabel().then{
        $0.text = "倒计时"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var countTextField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择卡卷领取结束时间"
        $0.datePicker?.datePickerMode = .date
        $0.dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    private let endCountLable = UILabel().then{
        $0.text = "截止日期"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var termTextField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择卡卷截止使用时间"
        $0.datePicker?.datePickerMode = .date
        $0.dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    private let numLable = UILabel().then{
        $0.text = "数量"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var numTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入商品数量"
        
    }
    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)


        contentView.addSubview(titleLable)
        contentView.addSubview(titleTextField)
        contentView.addSubview(priceLable)
        contentView.addSubview(priceTextField)
        contentView.addSubview(priceUnitLable)
        contentView.addSubview(numLable)
        contentView.addSubview(numTextField)
        contentView.addSubview(countLable)
        contentView.addSubview(countTextField)
        contentView.addSubview(endCountLable)
        contentView.addSubview(termTextField)

        
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
        
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.equalTo(fit(140))
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(titleLable.snp.right).offset(10)
            make.centerY.equalTo(titleLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        priceLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(titleLable.snp.bottom).snOffset(54)
            make.width.equalTo(fit(140))
        }
        priceTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(priceLable.snp.right).offset(10)
            make.centerY.equalTo(priceLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        priceUnitLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(priceTextField.snp.centerY)
        }
        
        countLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(priceLable.snp.bottom).snOffset(54)
            make.width.equalTo(fit(140))
            
        }
        countTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(countLable.snp.right).offset(10)
            make.centerY.equalTo(countLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        endCountLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(countLable.snp.bottom).snOffset(54)
            make.width.equalTo(fit(140))
            
        }
        
        termTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(endCountLable.snp.right).offset(10)
            make.centerY.equalTo(endCountLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        numLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(endCountLable.snp.bottom).snOffset(54)
            make.width.equalTo(fit(140))
            
        }
        
        numTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(numLable.snp.right).offset(10)
            make.centerY.equalTo(numLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
    }

}

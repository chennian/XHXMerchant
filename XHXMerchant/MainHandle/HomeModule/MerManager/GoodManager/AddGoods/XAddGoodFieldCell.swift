//
//  XAddGoodFieldCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddGoodFieldCell: SNBaseTableViewCell {
    
    private let line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    var titleLable = UILabel().then{
        $0.text = "商品名称"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var titleTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入商品名称"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    private let priceLable = UILabel().then{
        $0.text = "商品价格"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var priceTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入商品价格"
        $0.keyboardType = .decimalPad
    }
    
    private let cate = UILabel().then{
        $0.text = "商品分类"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }

    var cateTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入商品分类"
        
    }
    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        
        contentView.addSubview(titleLable)
        contentView.addSubview(titleTextField)
        contentView.addSubview(priceLable)
        contentView.addSubview(priceTextField)
        contentView.addSubview(cate)
        contentView.addSubview(cateTextField)
        hidLine()
        
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
        
        cate.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(priceLable.snp.bottom).snOffset(54)
            make.width.equalTo(fit(140))
            
        }
        
        cateTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(cate.snp.right).offset(10)
            make.centerY.equalTo(cate.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
    }
    
}

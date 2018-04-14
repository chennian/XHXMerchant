//
//  XMerLicenseFieldCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerLicenseFieldCell: SNBaseTableViewCell {
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
    
    var merShortName = UILabel().then{
        $0.text = "商户简称"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var merShortNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入商户简称"
    }
    var licenseName = UILabel().then{
        $0.text = "营业执照名称"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var licenseNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入银业执照名称"
    }
    
    var codeNum = UILabel().then{
        $0.text = "统一社会信用代码"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var codeNumField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入统一社会信用代码"
    }
    
    var licenseTerm = UILabel().then{
        $0.text = "营业执照有效期"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var licenseTermField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入营业执照有效期"
    }
    
    var area = UILabel().then{
        $0.text = "所在区域"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var areaField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择所在区域"
    }
    
    var detailAddress = UILabel().then{
        $0.text = "详细地址"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var detailAddressField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入详细地址"
    }
    
    var industryType = UILabel().then{
        $0.text = "行业类别"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    var industryTypeField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择行业类别"
    }

    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        contentView.addSubview(line5)
        contentView.addSubview(line6)

        contentView.addSubview(merShortName)
        contentView.addSubview(merShortNameField)
        contentView.addSubview(licenseName)
        contentView.addSubview(licenseNameField)
        contentView.addSubview(licenseTerm)
        contentView.addSubview(licenseTermField)
        contentView.addSubview(codeNum)
        contentView.addSubview(codeNumField)
        contentView.addSubview(area)
        contentView.addSubview(areaField)
        contentView.addSubview(detailAddress)
        contentView.addSubview(detailAddressField)
        contentView.addSubview(industryType)
        contentView.addSubview(industryTypeField)
        
        
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
        
        merShortName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(150)
        }
        
        merShortNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(merShortName.snp.right).offset(10)
            make.centerY.equalTo(merShortName.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        licenseName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(30)
        }
        
        licenseNameField.snp.makeConstraints { (make) in
            make.left.snEqualTo(licenseName.snp.right).offset(10)
            make.centerY.equalTo(licenseName.snp.centerY)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        licenseTerm.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line2.snp.bottom).snOffset(30)
        }
        
        licenseTermField.snp.makeConstraints { (make) in
            make.left.snEqualTo(licenseTerm.snp.right).offset(10)
            make.centerY.equalTo(licenseTerm.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        codeNum.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line3.snp.bottom).snOffset(30)
        }
        
        codeNumField.snp.makeConstraints { (make) in
            make.left.snEqualTo(codeNum.snp.right).offset(10)
            make.centerY.equalTo(codeNum.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        area.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line4.snp.bottom).snOffset(30)
        }
        
        areaField.snp.makeConstraints { (make) in
            make.left.snEqualTo(area.snp.right).offset(10)
            make.centerY.equalTo(area.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        detailAddress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line5.snp.bottom).snOffset(30)
        }
        
        detailAddressField.snp.makeConstraints { (make) in
            make.left.snEqualTo(detailAddress.snp.right).offset(10)
            make.centerY.equalTo(detailAddress.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        industryType.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line6.snp.bottom).snOffset(30)
        }
        
        industryTypeField.snp.makeConstraints { (make) in
            make.left.snEqualTo(industryType.snp.right).offset(10)
            make.centerY.equalTo(industryType.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
    }
}
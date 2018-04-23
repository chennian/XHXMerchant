//
//  XAddMerCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddMerCell: SNBaseTableViewCell {
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line3 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }

    
    var LicenseName = UILabel().then{
        $0.text = "营业执照名"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var LicenseNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入营业执照名"
    }
    var merShortName = UILabel().then{
        $0.text = "商户简称"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var merShortNameField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入商户简称"
    }
    var address = UILabel().then{
        $0.text = "所在区域"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var addressField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择所在区域"
    }
    
    var detailAddress = UILabel().then{
        $0.text = "详细地址"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    var detailAddressField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入详细地址"
    }

    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)

        contentView.addSubview(LicenseName)
        contentView.addSubview(LicenseNameField)
        contentView.addSubview(merShortName)
        contentView.addSubview(merShortNameField)
        contentView.addSubview(address)
        contentView.addSubview(addressField)
        contentView.addSubview(detailAddress)
        contentView.addSubview(detailAddressField)

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
        line3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line2.snp.bottom).snOffset(90)
        }
  
        
        LicenseName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line1.snp.top).snOffset(-30)
            make.width.snEqualTo(160)
        }
        LicenseNameField.snp.makeConstraints { (make) in
            make.left.equalTo(LicenseName.snp.right).snOffset(32)
            make.centerY.equalTo(LicenseName.snp.centerY)
            make.right.equalToSuperview().snOffset(80)
        }
        
        merShortName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line2.snp.top).snOffset(-30)
            make.width.snEqualTo(160)
        }
        merShortNameField.snp.makeConstraints { (make) in
            make.left.equalTo(merShortName.snp.right).snOffset(32)
            make.centerY.equalTo(merShortName.snp.centerY)
            make.right.equalToSuperview().snOffset(80)
        }
        address.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalTo(line3.snp.top).snOffset(-30)
            make.width.snEqualTo(160)
        }
        
        addressField.snp.makeConstraints { (make) in
            make.left.equalTo(address.snp.right).snOffset(32)
            make.centerY.equalTo(address.snp.centerY)
            make.right.equalToSuperview().snOffset(80)
        }
        
        detailAddress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line3.snp.bottom).snOffset(30)
            make.width.snEqualTo(160)
        }
        
        detailAddressField.snp.makeConstraints { (make) in
            make.left.equalTo(detailAddress.snp.right).snOffset(32)
            make.centerY.equalTo(detailAddress.snp.centerY)
            make.right.equalToSuperview().snOffset(80)
        }
    }
    
}

//
//  XUploadFrontBankCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XUploadFrontBankCell: SNBaseTableViewCell {
    
    let view = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let bankCardLable = UILabel().then{
        $0.text = "银行卡正面照"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let bankCardImg = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"bank_card"),for:.normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    let notice = UILabel().then{
        $0.text = "请上传银行卡正面照"
        $0.textColor = Color(0x9a9a9a)
        $0.font = Font(24)
    }
    
    var submitButton = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitle("提交", for:.normal)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(30)
    }

    override func setupView() {
        contentView.addSubview(view)
        view.addSubview(bankCardLable)
        view.addSubview(bankCardImg)
        view.addSubview(notice)
        contentView.addSubview(submitButton)
        
        self.backgroundColor = Color(0xf5f5f5)
        
        view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(20)
            make.height.snEqualTo(497)
        }
        bankCardLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(28)
            make.top.equalToSuperview().snOffset(36)
        }
        bankCardImg.snp.makeConstraints { (make) in
            make.top.equalTo(bankCardLable.snp.bottom).snOffset(75)
            make.centerX.equalToSuperview()
            make.height.snEqualTo(260)
            make.width.snEqualTo(483)
        }
        notice.snp.makeConstraints { (make) in
            make.centerX.equalTo(bankCardImg.snp.centerX)
            make.top.equalTo(bankCardImg.snp.bottom).snOffset(21)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(view.snp.bottom).snOffset(55)
            make.height.snEqualTo(100)
        }
        
        
    }

}

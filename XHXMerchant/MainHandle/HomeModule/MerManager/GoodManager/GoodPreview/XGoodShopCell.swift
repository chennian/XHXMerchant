//
//  XAddGoodShopCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodShopCell: SNBaseTableViewCell {
    
    var model:XMerListModel?{
        didSet{
            guard let cellModel =  model else {
                return
            }
            shopImg.kf.setImage(with: URL(string: cellModel.logo))
            shopName.text = cellModel.shopName
            address.text = cellModel.address
        }
    }
    
    var shopImg = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    
    var shopName = UILabel().then{
        $0.text = "点都德"
        $0.font = BoldFont(34)
        $0.textColor  = Color(0x313131)
    }
    
//    var distense = UIButton().then{
//        $0.titleLabel?.font = Font(26)
//        $0.setTitleColor(Color(0x565656), for: .disabled)
//        $0.isEnabled = false
//        $0.setImage(UIImage(named : "mapLoc"), for: .disabled)
//        $0.setTitle("200m", for: .disabled)
//
//    }
    
    let naviBtn = UIButton().then{
        $0.isEnabled = false
        $0.setImage(UIImage(named : "address"), for: .disabled)
    }
    
    let phoneBtn = UIButton().then{
        $0.isEnabled = false
        $0.setImage(UIImage(named : "telephone"), for: .disabled)
    }
    
//    private let sepLine = UIView().then{
//        $0.backgroundColor = Color(0x565656)
//    }
    
    var address = UILabel().then{
        $0.text = "深圳市龙华新区明治街道"
        $0.textColor  = Color(0x565656)
        $0.font = Font(26)
        
    }

    var classLable = UILabel().then{
        $0.backgroundColor = Color(0xffecec)
        $0.text = "小龙虾"
        $0.font = Font(24)
        $0.textColor = Color(0xff4242)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0xffc1c1).cgColor
    }
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(shopImg)
        contentView.addSubview(shopName)
//        contentView.addSubview(distense)
//        contentView.addSubview(sepLine)
        contentView.addSubview(address)
        contentView.addSubview(classLable)
        contentView.addSubview(naviBtn)
        contentView.addSubview(phoneBtn)

        shopImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(35)
            make.width.snEqualTo(160)
            make.height.snEqualTo(160)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.top.equalTo(shopImg.snp.top).snOffset(14)
            make.left.equalTo(shopImg.snp.right).snOffset(24)
        }
//        distense.snp.makeConstraints { (make) in
//            make.left.equalTo(shopName)
//            make.top.equalTo(shopName.snp.bottom).snOffset(22)
//            make.width.snEqualTo(100)
//            make.height.snEqualTo(24)
//        }
//        sepLine.snp.makeConstraints { (make) in
//            make.left.equalTo(distense.snp.right).snOffset(5)
//            make.width.snEqualTo(2)
//            make.height.snEqualTo(18)
//            make.centerY.snEqualTo(distense.snp.centerY)
//        }
        
        address.snp.makeConstraints { (make) in
            make.left.equalTo(shopImg.snp.right).snOffset(24)
            make.centerY.equalTo(shopImg.snp.centerY)
        }
 
        classLable.snp.makeConstraints { (make) in
            make.left.equalTo(shopName.snp.left)
            make.top.equalTo(address.snp.bottom).snOffset(20)
            make.height.snEqualTo(36)
        }
        phoneBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-20)
            make.centerY.equalTo(address.snp.centerY)
            make.width.height.snEqualTo(60)
        }
        
        naviBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(address.snp.centerY)
            make.width.height.snEqualTo(60)
            make.right.equalTo(phoneBtn.snp.left).snOffset(-30)
        }
    }
}

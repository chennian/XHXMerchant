//
//  XFlowMerCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XFlowMerCell: SNBaseTableViewCell {
    
        var models : FlowMerModel?{
            didSet{
                guard  let model = models else {return}
                nameLable.text = model.shopName
                principal.text = "负责人:\(model.realName)"
                address.text = "地址:\(model.address)"
            }
        }
    
    var img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "LBlogoIcon")
//        $0.layer.cornerRadius = fit(35)
//        $0.clipsToBounds = true
    }
    
    var nameLable = UILabel().then{
        $0.text = "木屋烧烤"
        $0.font = BoldFont(32)
        $0.textColor = Color(0x313131)
    }
    
    var principal = UILabel().then{
        $0.text = "负责人:尤泽清"
        $0.font = BoldFont(24)
        $0.textColor = Color(0x313131)
    }
    
    var address = UILabel().then{
        $0.font = Font(24)
        $0.text = "推荐时间:2018-01-11"
        $0.textColor = Color(0x313131)
    }
    
    var member = UILabel().then{
        $0.font = Font(24)
        $0.text = "成功"
        $0.textColor = Color(0x313131)
    }
    
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(nameLable)
        contentView.addSubview(principal)
        contentView.addSubview(address)
        contentView.addSubview(member)
        
        //        line.isHidden = true
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.height.width.snEqualTo(70)
        }
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalToSuperview().snOffset(30)
        }
        principal.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalTo(nameLable.snp.bottom).snOffset(17)
        }
        address.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(25)
            make.top.equalTo(principal.snp.bottom).snOffset(17)
        }
        
        member.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-29)
            make.centerY.equalTo(img.snp.centerY)
        }
    }
    
}

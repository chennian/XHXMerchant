//
//  XMerAddressCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/20.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerAddressCell: SNBaseTableViewCell {
    
    var model:BMKPoiInfo?{
        didSet{
            name.text = model?.name
            nameDesc.text = model?.address
        }
    }
    
    let img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "shop_address")
    }
    
    let name = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let nameDesc = UILabel().then{
        $0.textColor = Color(0xa3a2a2)
        $0.font = Font(26)
    }
    

    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(nameDesc)
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(26)
            make.height.snEqualTo(32)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(24)
            make.left.equalTo(img.snp.right).snOffset(30)
        }
        nameDesc.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).snOffset(17)
            make.left.equalTo(img.snp.right).snOffset(30)
        }

    }
}

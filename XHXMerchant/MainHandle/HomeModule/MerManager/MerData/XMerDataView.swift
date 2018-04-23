//
//  XMerDataView.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerDataView: SNBaseView {
    let name = UILabel().then{
        $0.text = "店铺名称"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    let nameLable = UILabel().then{
        $0.textColor = Color(0x737373)
        $0.font = Font(30)
    }
    
    let returnImg = UIImageView().then{
        $0.image = UIImage(named: "return1")
    }
    let line = UIView().then{
        $0.backgroundColor  = Color(0xe5e5e5)
    }

    override func setupView() {
        self.addSubview(name)
        self.addSubview(returnImg)
        self.addSubview(nameLable)
        self.addSubview(line)
        name.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.right).snOffset(24)
            make.centerY.equalTo(name.snp.centerY)
        }
        returnImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
            make.height.snEqualTo(24)
            make.width.snEqualTo(14)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.bottom.equalToSuperview()
        }

    }
}

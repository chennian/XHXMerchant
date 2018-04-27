//
//  XMenberListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMenberListCell: SNBaseTableViewCell {
    
    var model:XMenberListModel?{
        didSet{
            guard let cellModel  = model else {
                return
            }
            name.text = cellModel.username
            type.text = cellModel.detail
            time.text = cellModel.create_time
        }
    }
    
    let img = UIImageView().then{
        $0.image = UIImage(named: "LBlogoIcon")
    }

    let name = UILabel().then{
        $0.text = "余光大魔王"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let type = UILabel().then{
        $0.text = "hellO"
        $0.textColor = Color(0x313131)
        $0.font = Font(22)
    }
    
    let time = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(22)
    }
    override func setupView() {
        
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(type)
        contentView.addSubview(time)
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(80)
        }
        name.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(img.snp.top).snOffset(-20)
        }
        
        type.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(name.snp.bottom).snOffset(20)
        }
        time.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(type.snp.bottom).snOffset(20)
        }


    }

}

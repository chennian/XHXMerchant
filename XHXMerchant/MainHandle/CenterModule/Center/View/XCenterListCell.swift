//
//  XCenterListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XCenterListCell: SNBaseTableViewCell {
    
    let img = UIImageView().then{
        $0.backgroundColor = .clear
    }
    let lable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    let noticeImg = UIImageView().then{
        $0.backgroundColor = .clear
    }
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(lable)
        contentView.addSubview(noticeImg)

        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(22)
            make.centerY.equalTo(img.snp.centerY)
        }
        noticeImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(lable.snp.centerY)
        }
    }

}

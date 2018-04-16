//
//  MerHomeView.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class MerHomeView: SNBaseView {
    
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
    
    let line1 = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    
    override func setupView() {
        self.addSubview(img)
        self.addSubview(lable)
        self.addSubview(noticeImg)
        self.addSubview(line1)

        self.backgroundColor = .red
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
        line1.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.left.equalToSuperview().snOffset(100)
            make.bottom.equalToSuperview()
        }
    }
}

//
//  XNoticeRecordListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XNoticeRecordListCell: SNBaseTableViewCell {

    let imgview = UIImageView().then{
        $0.image = UIImage(named: "push")
    }
   
    let noticeLable = UILabel().then{
        $0.text = "接受支付金额3880.00"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let timeLable = UILabel().then{
        $0.text = "2018-09-22 23:11:11"
        $0.textColor = Color(0xadadad)
        $0.font = Font(22)
    }
    
    
    override func setupView() {
    
        contentView.addSubview(imgview)
        let baseview = UIView.init(frame: CGRect(x:fit(104), y: fit(20), width: fit(504), height: fit(103)))
        baseview.backgroundColor = Color(0xffffff)
        
        contentView.addSubview(baseview)
        baseview.addCorner(roundingCorners:UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topRight.rawValue) | UInt8(UIRectCorner.bottomRight.rawValue)|UInt8(UIRectCorner.bottomLeft.rawValue))), cornerSize: CGSize(width: fit(30), height: fit(30)))
        baseview.addSubview(noticeLable)
        contentView.addSubview(timeLable)
        hidLine()
        self.contentView.backgroundColor = Color(0xf5f5f5)
        imgview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(20)
        }
        
//        baseview.snp.makeConstraints { (make) in
//            make.left.equalTo(imgview.snp.right).snOffset(28)
//            make.top.equalTo(imgview.snp.top)
//            make.width.snEqualTo(504)
//            make.height.snEqualTo(103)
//        }
        
     
        noticeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(27)
            make.centerY.equalToSuperview()
        }

        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(noticeLable.snp.left)
            make.top.equalTo(baseview.snp.bottom).snOffset(16)
        }
        
    }

}


//
//  XMerListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerListCell: SNBaseTableViewCell {
    
    var model:XMerListModel?{
        didSet{
            guard let cellModel = model  else {
                return
            }
            self.merName.text = cellModel.shopName
            self.userNum.text = "会员数量:\(cellModel.flow_num)"
            self.merAddress.text = cellModel.address
            self.imgview.kf.setImage(with: URL(string: cellModel.logo))
        }
    }
    
    let imgview = UIImageView().then{
        $0.image = UIImage(named: "earnings_merchant")
    }
    
    let merName = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.text = "木屋烧烤"
        $0.font = BoldFont(34)
    }
    let userNum = UILabel().then{
        $0.textColor = Color(0x7a7a7a)
        $0.text = "会员数量:388"
        $0.font = Font(26)
    }
    let merAddress = UILabel().then{
        $0.textColor = Color(0x7a7a7a)
        $0.text = "地址:广东省深圳市龙华新区优诚商务大厦北区A栋1021"
        $0.font = Font(26)
        $0.numberOfLines = 0
    }
    override func setupView() {
        contentView.addSubview(imgview)
        contentView.addSubview(merName)
        contentView.addSubview(userNum)
        contentView.addSubview(merAddress)
        hidLine()
        imgview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(160)
        }
        merName.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).snOffset(22)
            make.top.equalTo(imgview.snp.top)
        }
        userNum.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).snOffset(22)
            make.top.equalTo(merName.snp.bottom).snOffset(18)
        }
        
        merAddress.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).snOffset(22)
            make.top.equalTo(userNum.snp.bottom).snOffset(15)
            make.width.snEqualTo(493)
        }
    }
}

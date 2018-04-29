//
//  XEarningDeatilTwoCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/23.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XEarningDayDetailTwoCell: SNBaseTableViewCell {
    
    var model :oneRevenueModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            if cellModel.nickName == ""{
                self.nameLable.text =  cellModel.shopName
            }else{
                self.nameLable.text =  cellModel.nickName
            }
            self.profit.text = cellModel.money
            self.des.text =    cellModel.credit
            self.timeLable.text = cellModel.add_time
        }
    }
    
    var img = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "earnings_merchant")
        //        $0.layer.cornerRadius = fit(35)
        //        $0.clipsToBounds = true
    }
    
    var nameLable = UILabel().then{
        $0.text = "木屋烧烤"
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    }
    
    var profit = UILabel().then{
        $0.text = "+ 0.99"
        $0.font = BoldFont(40)
        $0.textColor = Color(0x313131)
    }
    
    var des = UILabel().then{
        $0.font = Font(24)
        $0.text = "收款90笔"
        $0.textColor = Color(0x8e8e8e)
    }
    
    var timeLable = UILabel().then{
        $0.font = Font(24)
        $0.text = "收款90笔"
        $0.textColor = Color(0x8e8e8e)
    }
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(nameLable)
        contentView.addSubview(profit)
        contentView.addSubview(des)
        contentView.addSubview(timeLable)

        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.height.width.snEqualTo(80)
            make.centerY.equalToSuperview()
        }
        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(18)
            make.top.equalTo(img.snp.top).snOffset(10)
        }
        profit.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-27)
            make.centerY.equalTo(nameLable.snp.centerY)
            
        }
        
        timeLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(18)
            make.top.equalTo(profit.snp.bottom).snOffset(20)
        }
        des.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-27)
            make.centerY.equalTo(timeLable.snp.centerY)
        }
        
    }
    
}

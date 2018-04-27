//
//  XTotalEarningsListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningsListCell: SNBaseTableViewCell {
    
    var models:historyModel?{
        didSet{
            guard  let model = models  else {
                return
            }
            timelable.text = model.add_time
            moneyLable.text = model.credit
            desLable.text = "共\(model.num)笔交易"
        }
    }
    
    let timelable = UILabel().then{
        $0.text = "2018-04-17"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    let moneyLable = UILabel().then{
        $0.text = "2000.00"
        $0.textColor = Color(0x313131)
        $0.font = BoldFont(34)
    }
    let desLable = UILabel().then{
        $0.text = "共2000笔交易"
        $0.textColor = Color(0x9ea3aa)
        $0.font = Font(20)
    }
    
    
    override func setupView() {
        
        contentView.addSubview(timelable)
        contentView.addSubview(moneyLable)
        contentView.addSubview(desLable)
        timelable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(37)
        }
        
        moneyLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(timelable.snp.centerY)
        }
        
        desLable.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(moneyLable.snp.bottom).snOffset(11)
        }
    }

}

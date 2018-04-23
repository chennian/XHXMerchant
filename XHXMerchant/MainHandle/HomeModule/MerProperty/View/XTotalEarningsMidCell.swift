//
//  XTotalEarningsMidCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningsMidCell: SNBaseTableViewCell {
    
    var model:[String]?{
        didSet{
            guard let cellModel = model else {
                return
            }
            profitType.text = cellModel[0]
            profitLable.text = cellModel[1]
            profitDsc.text = "共\(cellModel[2])笔交易"  
        }
    }

    var profitType = UILabel().then{
        $0.text = "商家货款"
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
    }
   
    var profitLable = UILabel().then{
        $0.text = "1000"
        $0.font = BoldFont(34)
        $0.textColor = Color(0x313131)
    }
   
    var profitDsc = UILabel().then{
        $0.text = "共1000笔交易"
        $0.font = Font(20)
        $0.textColor = Color(0x9ea3aa)
    }
   

    override func setupView() {
        contentView.addSubview(profitType)
        contentView.addSubview(profitLable)
        contentView.addSubview(profitDsc)
        
        profitType.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(34)
        }
        
        profitLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(34)
            make.right.equalToSuperview().snOffset(-30)
        }
        profitDsc.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(profitLable.snp.bottom).snOffset(11)
        }
        
    }
        
     

}



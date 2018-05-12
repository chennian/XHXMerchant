//
//  XCashRecordCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XCashRecordCell: SNBaseTableViewCell {
    
    var models : CashListModel?{
        didSet{
            guard let cellModel = models else{ return }
            name.text = cellModel.bankname
            time.text = cellModel.add_time
            money.text = cellModel.money
            
            if cellModel.status == "1"{
                status.textColor = Color(0xff0000)
                status.text = "审核中"
            }else if cellModel.status == "2"{
                status.textColor = Color(0xff0000)
                status.text = "审核失败"

            }else{
                status.textColor = Color(0x282828)
                status.text = "审核成功"

            }
            
        }
    }

    let name = UILabel().then{
        $0.text = "兑换到农业银行卡(1225)"
        $0.textColor = Color(0x282828)
        $0.font = Font(30)
    }
    
    let status = UILabel().then{
        $0.text = "提现中"
        $0.textColor = Color(0xff0000)
        $0.font = Font(30)
    }
    
    let time = UILabel().then{
        $0.text = "2017-01-25"
        $0.textColor = Color(0x878787)
        $0.font = Font(28)
    }
    
    let money = UILabel().then{
        $0.text = "300.00"
        $0.font = BoldFont(30)
        $0.textColor = Color(0x313131)
    }
    
    override func setupView() {
        contentView.addSubview(name)
        contentView.addSubview(status)
        contentView.addSubview(time)
        contentView.addSubview(money)
        
        name.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(20)
        }
        status.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(name.snp.centerY)
        }
        
        time.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.bottom.equalToSuperview().snOffset(-20)
        }
        
        money.snp.makeConstraints { (make) in
            make.centerY.equalTo(time.snp.centerY)
            make.right.equalToSuperview().snOffset(-30)
        }

    }

}

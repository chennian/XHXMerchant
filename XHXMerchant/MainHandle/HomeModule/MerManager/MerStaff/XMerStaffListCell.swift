//
//  XMerStaffListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerStaffListCell: SNBaseTableViewCell {
    
    var model:XMerStaffList?{
        didSet{
            guard let cellModel = model else {
                return
            }
            name.text = cellModel.names
            accountName.text = "账号:\(cellModel.employee)"
        }
    }

    let imgview = UIImageView().then{
        $0.backgroundColor = .red
    }
    let name = UILabel().then{
        $0.font = BoldFont(32)
        $0.text = "贱人"
        $0.textColor = Color(0x636363)
    }
    let accountName = UILabel().then{
        $0.font = Font(26)
        $0.text = "账号：xiaoheixiong@skfjli"
        $0.textColor = Color(0x636363)
    }
    override func setupView() {
        contentView.addSubview(imgview)
        contentView.addSubview(name)
        contentView.addSubview(accountName)
        hidLine()
        imgview.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().snOffset(30)
            make.width.height.snEqualTo(70)
        }
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).snOffset(28)
            make.top.equalTo(imgview.snp.top)
        }
        accountName.snp.makeConstraints { (make) in
            make.left.equalTo(imgview.snp.right).snOffset(28)
            make.top.equalTo(name.snp.bottom).snOffset(18)
        }
        
    }

}

//
//  XGoodEditCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodEditCell: UITableViewCell {
    
    var models:GoodListModel?{
        didSet{
            guard let cellModel = models else {
                return
            }
            img.kf.setImage(with: URL(string: cellModel.main_img))
            name.text = cellModel.name
            price.text = "价格:￥\(cellModel.price)"
            num.text = "销量：\(cellModel.sell_num)"
        }
    }
    
    let img = UIImageView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.contentMode = .scaleToFill
    }
    let name = UILabel().then{
        $0.text = "沙拉"
        $0.textColor = Color(0x313131)
        $0.font = Font(32)
    }
    let price = UILabel().then{
        $0.text = "价格:￥190.00"
        $0.textColor = Color(0xf70e0e)
        $0.font = Font(26)
    }
    
    let num = UILabel().then{
        $0.text = "销量：11190"
        $0.textColor = Color(0x7a7a7a)
        $0.font = Font(26)
    }
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(price)
        contentView.addSubview(num)
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.height.width.snEqualTo(140)
            make.centerY.equalToSuperview()
        }
        name.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.top.equalTo(img.snp.top)
        }
        price.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.centerY.equalTo(img.snp.centerY)
        }
        
        num.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(20)
            make.bottom.equalTo(img.snp.bottom)
        }
    }
}

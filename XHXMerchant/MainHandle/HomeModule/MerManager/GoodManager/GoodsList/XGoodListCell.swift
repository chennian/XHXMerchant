//
//  XGoodListCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XGoodListCell: SNBaseTableViewCell {
    
    var soldEvent:(()->())?
    var previewEvent:(()->())?

    
    var models :GoodListModel?{
        didSet{
            guard let cellModel = models  else {
                return
            }
            img.kf.setImage(with: URL(string: "\(cellModel.main_img)"))
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

    let leftBtn = UIButton().then{
        $0.setTitle("预览", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(24)
        $0.setImage(UIImage(named: "commodity_preview"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-20))
        
    }
    let rightBtn = UIButton().then{
        $0.setTitle("下架", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(24)
        $0.setImage(UIImage(named: "commodity_sold_out"), for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-20))
    }

    
    func bindEvent(){
        leftBtn.addTarget(self, action: #selector(preview), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(sold), for: .touchUpInside)
    }
    @objc func preview(){
        guard let action = previewEvent else {
            return
        }
        action()
    }
    @objc func sold(){
        guard let action = soldEvent else {
            return
        }
        action()
    }
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(price)
        contentView.addSubview(num)
        contentView.addSubview(leftBtn)
        contentView.addSubview(rightBtn)

        bindEvent()
        
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
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.width.snEqualTo(100)
            make.height.snEqualTo(30)
            make.centerY.equalTo(num.snp.centerY)
        }
        leftBtn.snp.makeConstraints { (make) in
            make.right.snEqualTo(rightBtn.snp.left).snOffset(-30)
            make.width.snEqualTo(100)
            make.height.snEqualTo(30)
            make.centerY.equalTo(rightBtn.snp.centerY)
        }
        
        
    }
}

//
//  XTotalEarningsEndCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XTotalEarningsEndCell: SNBaseTableViewCell {
    
    var btnClickEvent:(()->())?

    var img = UIImageView().then{
        $0.backgroundColor = .red
        //        $0.image = UIImage(named: "")
    }
    
    var historyLable = UILabel().then{
        $0.text = "历史收益"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var more = UIButton().then{
        $0.setTitle("查看更多", for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setImage(UIImage(named: "map_return1"), for:UIControlState.normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fit(-270))
        
    }
    var view1 = UIView().then{
        $0.backgroundColor = .clear
    }
    func bindEvent() {
   
        more.addTarget(self, action: #selector(btnClick), for:.touchUpInside)

    }
    
   @objc func btnClick(){
        guard let btnClickAction = btnClickEvent else {
            return
        }
        btnClickAction()
    }
    
    override func setupView() {
        contentView.addSubview(view1)
        view1.addSubview(historyLable)
        view1.addSubview(more)
        view1.addSubview(img)
        
        bindEvent()
    
        view1.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(90)
        }
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(42)
        }
        historyLable.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(img.snp.right).snOffset(15)
        }
        more.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(150)
            make.height.snEqualTo(40)
        }

    }
    
}


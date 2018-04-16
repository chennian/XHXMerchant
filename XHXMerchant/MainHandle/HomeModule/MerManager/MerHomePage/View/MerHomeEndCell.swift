//
//  MerHomeEndCellTableViewCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class MerHomeEndCell: SNBaseTableViewCell {
    
    let mainView = UIView().then{
        $0.layer.cornerRadius = fit(8)
        $0.backgroundColor = Color(0xffffff)
    }
    
    let viewOne = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_member")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "会员管理"
    }
    let viewTwo = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_staff")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "员工账号"
    }
    let viewThree = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_coupon")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "卡卷核销"
    }
    let viewFour = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_classify")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "商品分类"
    }
    
    override func setupView() {
        contentView.addSubview(mainView)
        mainView.addSubview(viewOne)
        mainView.addSubview(viewTwo)
        mainView.addSubview(viewThree)
        mainView.addSubview(viewFour)
        self.contentView.backgroundColor = Color(0xf5f5f5)
        line.isHidden = true
        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(30)
            make.bottom.equalToSuperview()
        }
        viewOne.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(100)
        }
        viewTwo.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(100)
            make.top.equalTo(viewOne.snp.bottom)
        }
        viewThree.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(100)
            make.top.equalTo(viewTwo.snp.bottom)
        }
        viewFour.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(100)
            make.top.equalTo(viewThree.snp.bottom)
        }
    }
    
}

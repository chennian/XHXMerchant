//
//  MerHomeCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class MerHomeTopCell: SNBaseTableViewCell {
    
    var clickEvent:((_ para :String)->())?
    
    let mainView = UIView().then{
        $0.layer.cornerRadius = fit(8)
        $0.backgroundColor = Color(0xffffff)
    }
    
    let viewOne = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_gathering")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "收款码"
        $0.tag = 1
    }
    let viewTwo = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_datum")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "商家资料"
        $0.tag = 2
    }
    let viewThree = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_seckill")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "团团秒秒"
        $0.tag = 3
    }
    let viewFour = MerHomeView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.img.image = UIImage(named: "shop_management")
        $0.noticeImg.image = UIImage(named: "return1")
        $0.lable.text = "商品管理"
        $0.tag = 4
    }
    
    @objc func tapOne(_ view:UIView){
        guard let action = clickEvent else{return}
        action("1")
    }
    @objc func tapTwo(_ view:UIView){
        guard let action = clickEvent else{return}
        action("2")
    }
    @objc func tapThree(_ view:UIView){
        guard let action = clickEvent else{return}
        action("3")
    }
    @objc func tapFour(_ view:UIView){
        guard let action = clickEvent else{return}
        action("4")
    }
    
    func bindEvent(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapOne))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapTwo))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapThree))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(tapFour))

        viewOne.addGestureRecognizer(tap1)
        viewTwo.addGestureRecognizer(tap2)
        viewThree.addGestureRecognizer(tap3)
        viewFour.addGestureRecognizer(tap4)
    }
  
    override func setupView() {
        contentView.addSubview(mainView)
        mainView.addSubview(viewOne)
        mainView.addSubview(viewTwo)
        mainView.addSubview(viewThree)
        mainView.addSubview(viewFour)
        self.contentView.backgroundColor = Color(0xf5f5f5)
        line.isHidden = true
        bindEvent()
        
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

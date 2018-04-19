//
//  XMerDataEndCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerDataEndCell: SNBaseTableViewCell {
    
    var clickBlock:((_ para:String)->())?

    let viewOne = XMerDataView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.name.text = "店铺简称"
    }
    let viewTwo = XMerDataView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.name.text = "服务电话"

    }
    let viewThree = XMerDataView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.name.text = "店铺类别"

    }
    let viewFour = XMerDataView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.name.text = "店铺标签"

    }
    let viewFive = XMerDataView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.name.text = "店铺位置"
        
    }
    
    @objc func  tapOne(){
        guard let action = clickBlock else{ return }
        action("1")
    }
    @objc func  tapTwo(){
        guard let action = clickBlock else{ return }
        action("2")
    }
    @objc func  tapThree(){
        guard let action = clickBlock else{ return }
        action("3")
    }
    @objc func  tapFour(){
        guard let action = clickBlock else{ return }
        action("4")
    }
    @objc func  tapFive(){
        guard let action = clickBlock else{ return }
        action("5")
    }
    
    func bindEvent(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapOne))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapTwo))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapThree))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(tapFour))
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(tapFive))

        
        viewOne.addGestureRecognizer(tap1)
        viewTwo.addGestureRecognizer(tap2)
        viewThree.addGestureRecognizer(tap3)
        viewFour.addGestureRecognizer(tap4)
        viewFive.addGestureRecognizer(tap5)

    }
    
    override func setupView() {
        contentView.addSubview(viewOne)
        contentView.addSubview(viewTwo)
        contentView.addSubview(viewThree)
        contentView.addSubview(viewFour)
        contentView.addSubview(viewFive)
        
        bindEvent()

        
        viewOne.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(100)
        }
        viewTwo.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewOne.snp.bottom)
            make.height.snEqualTo(100)
        }
        viewThree.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewTwo.snp.bottom)
            make.height.snEqualTo(100)
        }
        viewFour.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewThree.snp.bottom)
            make.height.snEqualTo(100)
        }
        viewFive.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewFour.snp.bottom)
            make.height.snEqualTo(100)
        }

    }

}

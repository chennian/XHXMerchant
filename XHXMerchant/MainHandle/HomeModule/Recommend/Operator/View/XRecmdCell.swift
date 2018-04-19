//
//  XRecmdCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift

class XRecmdCell: SNBaseTableViewCell {
    
    var clickEvent:((_ para:Int)->())?

    let img = UIImageView().then{
        $0.image = UIImage(named: "above")
    }
    
    let viewOne = UIView().then{
        $0.backgroundColor = Color(0x352e5d)
    }
    
    let codeImage = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let ercodeView = ZJPayErCodeContetnView().then({
        $0.layer.cornerRadius = fit(10)
        
    })
    let notice = UILabel().then{
        $0.text = "长按保存二维码"
        $0.textColor = Color(0xffffff)
        $0.font = Font(30)
    }
    
    let recmdMerBtn = UIButton().then{
        $0.setTitle("推荐商家", for: .normal)
        $0.setTitleColor(Color(0x333333), for: .normal)
        $0.backgroundColor = Color(0xffe402)
        $0.layer.cornerRadius = fit(4)
        $0.titleLabel?.font = Font(32)
        $0.tag = 1
    }
    
    let recmdOperBtn = UIButton().then{
        $0.setTitle("推荐用户", for: .normal)
        $0.setTitleColor(Color(0x333333), for: .normal)
        $0.backgroundColor = Color(0xffe402)
        $0.layer.cornerRadius = fit(4)
        $0.titleLabel?.font = Font(32)
        $0.tag = 2
    }
    
    let myRcmd = UILabel().then{
        $0.text = "我的推荐人:\(XKeyChain.get(PARENTPHONE))"
        $0.textColor = Color(0xdbe9e7)
        $0.font = Font(30)
        $0.backgroundColor = Color(0x2a2259)
        $0.textAlignment = .center
        $0.layer.cornerRadius = fit(10)
    }
    
    func bindEvent(){
        recmdMerBtn.addTarget(self, action: #selector(recmdMer), for: .touchUpInside)
        recmdOperBtn.addTarget(self, action: #selector(recmdMer), for: .touchUpInside)

    }
    @objc func recmdMer(_ btn:UIButton){
        guard let action = clickEvent else {
            return
        }
        action(btn.tag)
    }
    
    override func setupView() {
        contentView.addSubview(img)
        contentView.addSubview(viewOne)
        viewOne.addSubview(codeImage)
        viewOne.addSubview(notice)
        viewOne.addSubview(recmdMerBtn)
        viewOne.addSubview(recmdOperBtn)
        viewOne.addSubview(myRcmd)
        codeImage.addSubview(ercodeView)

        bindEvent()
        self.ercodeView.creatErcode()

        img.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(534)
        }
        viewOne.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(img.snp.bottom)
        }
        
        codeImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(27)
            make.width.height.snEqualTo(322)
        }
        
        ercodeView.snp.makeConstraints { (make) in
            make.centerX.equalTo(codeImage.snp.centerX)
            make.centerY.equalTo(codeImage.snp.centerY)
            make.width.height.snEqualTo(314)
        }
        
        notice.snp.makeConstraints { (make) in
            make.top.equalTo(codeImage.snp.bottom).snOffset(24)
            make.centerX.equalTo(codeImage.snp.centerX)
        }
        
        recmdMerBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(codeImage.snp.centerX)
            make.top.equalTo(codeImage.snp.bottom).snOffset(156)
            make.height.snEqualTo(90)
            make.width.snEqualTo(600)
        }
        
        recmdOperBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(recmdMerBtn.snp.centerX)
            make.top.equalTo(recmdMerBtn.snp.bottom).snOffset(56)
            make.height.snEqualTo(90)
            make.width.snEqualTo(600)
        }
        
        myRcmd.snp.makeConstraints { (make) in
            make.top.equalTo(recmdOperBtn.snp.bottom).snOffset(94)
            make.centerX.equalTo(recmdOperBtn.snp.centerX)
            make.width.snEqualTo(560)
            make.height.snEqualTo(120)
        }
        
        
        
    }


}

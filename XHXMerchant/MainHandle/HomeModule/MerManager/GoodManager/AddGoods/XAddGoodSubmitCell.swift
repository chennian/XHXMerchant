//
//  XAddGoodSubmitCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddGoodSubmitCell:SNBaseTableViewCell{
var clickBtnEvent:(()->())?

var submitBoutton = UIButton().then{
    $0.backgroundColor = Color(0x272424)
    $0.layer.cornerRadius = fit(4)
    $0.setTitleColor(UIColor.white, for:UIControlState.normal)
    $0.titleLabel?.font = Font(30)
    $0.titleLabel?.textColor = .white
}

func bindEvent(){
    submitBoutton.addTarget(self, action: #selector(submit), for: .touchUpInside)
}
@objc func submit(){
    guard let clickEvent = clickBtnEvent else {return}
    clickEvent()
}
override func setupView() {
    self.backgroundColor = Color(0xf5f5f5)
    contentView.addSubview(submitBoutton)
    bindEvent()
    hidLine()
    submitBoutton.snp.makeConstraints { (make) in
        make.top.equalToSuperview().snOffset(87)
        make.left.equalToSuperview().snOffset(30)
        make.right.equalToSuperview().snOffset(-30)
        make.height.snEqualTo(100)
        
    }
    
    }
    
}

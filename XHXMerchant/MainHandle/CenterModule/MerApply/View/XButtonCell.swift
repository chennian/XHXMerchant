//
//  XButtonCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XButtonCell: SNBaseTableViewCell {
    
    var clickBtnEvent:((_ para:String)->())?

    var submitBoutton = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(30)
        $0.titleLabel?.textColor = .white
    }
    
    func bindEvent(){
        submitBoutton.addTarget(self, action: #selector(stepOne), for: .touchUpInside)
    }
    @objc func stepOne(){
        clickBtnEvent!("1")
    }
    override func setupView() {
        contentView.addSubview(submitBoutton)
        bindEvent()
        submitBoutton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(100)
            make.centerY.equalToSuperview()
        }
        
    }

}

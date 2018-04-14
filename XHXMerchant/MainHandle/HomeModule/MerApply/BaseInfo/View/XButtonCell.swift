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
        guard let clickEvent = clickBtnEvent else {return}
        clickEvent("1")
    }
    override func setupView() {
        self.backgroundColor = Color(0xf5f5f5)
        contentView.addSubview(submitBoutton)
        bindEvent()
        submitBoutton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(87)
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(100)
        }
        
    }

}

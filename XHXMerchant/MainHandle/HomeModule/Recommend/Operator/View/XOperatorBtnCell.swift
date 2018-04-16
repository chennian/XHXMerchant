//
//  XOperatorBtnCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XOperatorBtnCell: SNBaseTableViewCell {
    
    var clickEvent:(()->())?

    var submitBtn = UIButton().then{
        $0.setTitle("提交", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.titleLabel?.font = Font(32)
    }
    
    @objc func click(){
        guard let action = clickEvent else {
            return
        }
        action()
    }
    
    override func setupView() {
        self.backgroundColor = .clear
        contentView.addSubview(submitBtn)
        
        submitBtn.addTarget(self, action: #selector(click), for: .touchUpInside)
        submitBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(100)
            make.top.equalToSuperview().snOffset(70)
        }
        
    }

}

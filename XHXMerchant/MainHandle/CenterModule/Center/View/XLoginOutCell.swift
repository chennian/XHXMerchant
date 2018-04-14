//
//  XLoginOutCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit


class XLoginOutCell: SNBaseTableViewCell {

    var clickEvent:(()->())?
    
    let loginOutBtn = UIButton().then{
        $0.backgroundColor = Color(0xffffff)
        $0.setTitle("退出登录", for: .normal)
        $0.setTitleColor(Color(0xff0000), for: .normal)
        $0.titleLabel?.font = Font(30)
    }
    @objc func click()  {
        guard let action = clickEvent else {return}
        action()
    }
    override func setupView() {
        contentView.addSubview(loginOutBtn)
        loginOutBtn.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        loginOutBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.snEqualTo(150)
            make.height.snEqualTo(30)
        }
    }
    
}

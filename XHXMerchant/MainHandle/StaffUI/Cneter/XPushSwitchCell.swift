//
//  XPushSwitchCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XPushSwitchCell: SNBaseTableViewCell {
    
    var clickEvent:((_ sender:UISwitch)->())?

    let name = UILabel().then{
        $0.text = "推送开发"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    let pushSwitch = UISwitch()
    
    func  bindEvent(){
        pushSwitch.addTarget(self, action: #selector(isSwitch), for: UIControlEvents.valueChanged)
    }
    
    @objc func isSwitch(sender:UISwitch){
        guard let action = clickEvent else {
            return
        }
        action(self.pushSwitch)
    }
    
    override func setupView() {
        contentView.addSubview(name)
        contentView.addSubview(pushSwitch)
        hidLine()
        bindEvent()
        name.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        pushSwitch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
        }

    }

}

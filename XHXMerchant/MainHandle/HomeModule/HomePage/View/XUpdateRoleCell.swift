//
//  XUpdateRoleCell.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XUpdateRoleCell: SNBaseTableViewCell {
    
    private var line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private var line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    var view1 = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    var view2 = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    var view3 = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    
    var parentLable = UILabel().then{
        $0.text = "我的推荐人:17603078066"
        $0.textColor = Color(0x717171)
        $0.font = Font(24)
    }
    
    var accountLable = UILabel().then{
        $0.text = "我的账号   17603078066"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var updateRole = UILabel().then{
        $0.text = "升级等级"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    
    var updateRoleLable = UILabel().then{
        $0.text = "服务商"
        $0.textColor = Color(0x006cff)
        $0.font = Font(30)
    }
    
    var codeLable = UILabel().then{
        $0.text = "短息验证"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    var codeLableField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入验证码"
    }
    
    var timeButton = TimerButton().then{
        $0.timeLength = 60
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    var submitButton = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitle("提交申请", for:.normal)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(30)
        $0.titleLabel?.textColor = .white
    }
    
    override func setupView() {
        contentView.addSubview(view1)
        contentView.addSubview(view2)
        contentView.addSubview(view3)
        contentView.addSubview(parentLable)
        contentView.addSubview(submitButton)
        
        view1.addSubview(accountLable)
        view2.addSubview(updateRole)
        view2.addSubview(updateRoleLable)
        view3.addSubview(codeLable)
        view3.addSubview(codeLableField)
        view3.addSubview(timeButton)
        view2.addSubview(line1)
        view3.addSubview(line2)
        
        self.backgroundColor = Color(0xf5f5f5)
        
        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)
        
        view1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(80)
            make.height.snEqualTo(100)
        }
        view2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view1.snp.bottom)
            make.height.snEqualTo(100)
        }
        view3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view2.snp.bottom)
            make.height.snEqualTo(100)
        }
        line1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.bottom.equalTo(view1.snp.bottom)
        }
        line2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.bottom.equalTo(view2.snp.bottom)
        }
        parentLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(29)
            make.top.equalToSuperview().snOffset(38)
        }
        
        accountLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(31)
            make.centerY.equalToSuperview()
        }
        
        updateRole.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(31)
            make.centerY.equalToSuperview()
        }
        
        updateRoleLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(updateRole.snp.centerY)
            make.left.equalTo(updateRole.snp.right).snOffset(32)
        }
        
        codeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        
        codeLableField.snp.makeConstraints { (make) in
            make.left.equalTo(codeLable.snp.right).snOffset(32)
            make.centerY.equalTo(codeLable.snp.centerY)
            make.width.snEqualTo(200)
        }
        
        timeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(codeLableField.snp.centerY)
            make.width.snEqualTo(180)
            make.height.snEqualTo(65)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(view3.snp.bottom).snOffset(85)
            make.height.snEqualTo(100)
        }

    }

}

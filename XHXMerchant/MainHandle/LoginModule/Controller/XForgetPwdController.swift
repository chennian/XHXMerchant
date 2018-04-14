//
//  XForgetPwdController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XForgetPwdController: SNBaseViewController {

    let viewOne = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let phoneLable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.text = "手机号"
    }
    let codeLable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.text = "验证码"
    }
    let phoneField = UITextField().then{
        $0.placeholder = "请输入手机号"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.borderStyle = .none
    }
    let codeField = UITextField().then{
        $0.placeholder = "请输入验证码"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.borderStyle = .none
    }
    let lineOne = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    var timeButton = TimerButton().then{
        $0.timeLength = 60
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    var submitButton = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitle("确定", for:.normal)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(30)
    }
    @objc func verify(){
        self.navigationController?.pushViewController(XForgetStepTwoController(), animated: true)
    
    }
    override func setupView() {
        
        self.view.backgroundColor = Color(0xf5f5f5)
        self.title = "找回密码"
        
        self.view.addSubview(viewOne)
        viewOne.addSubview(phoneLable)
        viewOne.addSubview(phoneField)
        viewOne.addSubview(codeLable)
        viewOne.addSubview(codeField)
        viewOne.addSubview(lineOne)
        viewOne.addSubview(timeButton)
        self.view.addSubview(submitButton)

        timeButton.setup("获取验证码", timeTitlePrefix: "", aTimeLength: 60)
        submitButton.addTarget(self, action: #selector(verify), for: .touchUpInside)
        
        viewOne.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(40)
            make.height.snEqualTo(180)
        }
        lineOne.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.centerY.equalToSuperview()
        }
        
        phoneLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
        }
        phoneField.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLable.snp.right).snOffset(60)
            make.centerY.equalTo(phoneLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        codeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(lineOne.snp.bottom).snOffset(30)
        }
        codeField.snp.makeConstraints { (make) in
            make.left.equalTo(codeLable.snp.right).snOffset(60)
            make.centerY.equalTo(codeLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        timeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(codeField.snp.centerY)
            make.width.snEqualTo(180)
            make.height.snEqualTo(60)
        }
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(viewOne.snp.bottom).snOffset(90)
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(100)
        }

    }
}

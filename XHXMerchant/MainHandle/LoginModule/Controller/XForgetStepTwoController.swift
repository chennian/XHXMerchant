//
//  XForgetStepTwoController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XForgetStepTwoController: SNBaseViewController {
    
    var mobile:String = ""
    var code :String = ""
    
    let viewOne = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let pwdLable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.text = "新密码"
    }
    let confirmLable = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.text = "确认密码"
    }
    let pwdField = UITextField().then{
        $0.placeholder = "请输入新密码"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.borderStyle = .none
        $0.isSecureTextEntry = true
    }
    let confirmField = UITextField().then{
        $0.placeholder = "请输入确认密码"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.borderStyle = .none
        $0.isSecureTextEntry = true
    }
    let lineOne = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    var submitButton = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitle("确定", for:.normal)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(30)
    }
    @objc func confirm(){
        if self.pwdField.text == "" {
            UIAlertView(title: "温馨提示", message:"请输入新密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  self.confirmField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入确认手机号码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.pwdField.text != self.confirmField.text{
            UIAlertView(title: "温馨提示", message:"两次输入密码不一致", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
       
        SNRequestBool(requestType: API.alterAccountPwd(mobile: mobile, code: code, password: self.confirmField.text!)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                UIAlertView(title: "温馨提示", message: "修改成功，请重新登录", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                self.navigationController?.popToRootViewController(animated: false)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: self.disposeBag)
    }
    override func setupView() {
        
        self.view.backgroundColor = Color(0xf5f5f5)
        self.title = "找回密码"
        
        self.view.addSubview(viewOne)
        viewOne.addSubview(pwdLable)
        viewOne.addSubview(pwdField)
        viewOne.addSubview(confirmLable)
        viewOne.addSubview(confirmField)
        viewOne.addSubview(lineOne)
        self.view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
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
        
        pwdLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(150)
        }
        pwdField.snp.makeConstraints { (make) in
            make.left.equalTo(pwdLable.snp.right).snOffset(60)
            make.centerY.equalTo(pwdLable.snp.centerY)
            make.width.snEqualTo(300)
        }
        confirmLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(lineOne.snp.bottom).snOffset(30)
            make.width.snEqualTo(150)

        }
        confirmField.snp.makeConstraints { (make) in
            make.left.equalTo(confirmLable.snp.right).snOffset(60)
            make.centerY.equalTo(confirmLable.snp.centerY)
            make.width.snEqualTo(300)
        }

        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(viewOne.snp.bottom).snOffset(90)
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(100)
        }
        
    }
}

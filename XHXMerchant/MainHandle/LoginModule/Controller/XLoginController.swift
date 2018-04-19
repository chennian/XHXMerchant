//
//  XLoginController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import SVProgressHUD


class XLoginController: SNBaseViewController
{
    
    var model :[TokenModel] = []
    
    var userModel : [UserModel] = []


    let imgViewOne = UIImageView().then{
        $0.image = UIImage(named: "logo")
    }
    
    let imgViewTwo = UIImageView().then{
        $0.image = UIImage(named: "logo_name")
    }
    
    let imgPhone = UIImageView().then{
        $0.image = UIImage(named: "register_phone")
    }
    let imgPassword = UIImageView().then{
        $0.image = UIImage(named: "register_password")
    }
    
    var phoneField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入手机号"
    }
    var passwordField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入密码"
        $0.isSecureTextEntry = true
    }
    
    let  line1  = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    let  line2  = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    let  line3  = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    
    let submitBtn = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(32)
        $0.setTitle("登录", for: .normal)
    }
    
    let notice = UIButton().then {
        $0.setTitle("忘记密码", for: .normal)
        $0.titleLabel?.font = Font(26)
        $0.setTitleColor(Color(0x504e4e), for: .normal)
        $0.backgroundColor = Color(0xffffff)
    }
    @objc func findPwd() {
        self.navigationController?.pushViewController(XForgetPwdController(), animated: true)
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        getUserInfo()
        self.navigationController?.navigationBar.isHidden = false

    }
    
    
    fileprivate func submitLogin(){
        SNRequest(requestType: API.login(phone:phoneField.text! , password: passwordField.text!), modelType: [TokenModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                SZHUDDismiss()
                self.model = models
                let token = self.model.map({return $0.token})
                let timestamp = self.model.map({return $0.timestamp})
                XKeyChain.set("1", key: ISLOGIN)
                XKeyChain.set(self.phoneField.text!, key:PHONE )
                XKeyChain.set(self.passwordField.text!, key: PASSWORD)
                XKeyChain.set(token[0], key: TOKEN)
                XKeyChain.set(timestamp[0], key:TIMESTAMP)
                self.getUserInfo()
                
            case .fail(let code,let msg):
                SZHUDDismiss()
                
                UIAlertView(title: "提示", message: msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                SZHUDDismiss()

                break
            }
        }).disposed(by: disposeBag)
        
    }
    @objc func loginAction(){
        
        CNLog(phoneField.text! + passwordField.text!)
        
        if phoneField.text == ""
        {
            UIAlertView(title: "提示", message: "请输入手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        
        if passwordField.text == ""
        {
            UIAlertView(title: "提示", message: "请输入密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
       
        let time: TimeInterval = 1.0
        SZHUD("登录中...", type: .loading, callBack: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            self.submitLogin()
        }
    }
    
    func getUserInfo(){
        SNRequest(requestType: API.getUserInfo, modelType: [UserModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.userModel = models
                CNLog(models)
                let phone = self.userModel.map({return $0.phone})
                let isMer = self.userModel.map({return $0.isMer})
                let isAgent = self.userModel.map({return $0.isAgent})
                let roles = self.userModel.map({return $0.roles})
                let nikeName = self.userModel.map({return $0.nickName})
                let parentPhone = self.userModel.map({return $0.parent_phone})
                let operater = self.userModel.map({return $0.operater})
                let corporation = self.userModel.map({return $0.corporation})
                
                XKeyChain.set(isMer[0], key:IsMer )
                XKeyChain.set(isAgent[0], key:IsAgent )
                XKeyChain.set(roles[0], key:ROLE )
                XKeyChain.set(nikeName[0], key:NickName)
                XKeyChain.set(parentPhone[0], key:PARENTPHONE)
                XKeyChain.set(operater[0], key:OPERATER)
                XKeyChain.set(corporation[0], key:CORPORATION)
                CNLog(XKeyChain.get(IsAgent) + XKeyChain.get(OPERATER) + XKeyChain.get(CORPORATION))
                self.navigationController?.popViewController(animated: false)

            case .fail(_,let msg):
                SZHUD( msg ?? "获取个人信息失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    
    override func setupView() {
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(imgViewOne)
        self.view.addSubview(imgViewTwo)
        self.view.addSubview(imgPhone)
        self.view.addSubview(imgPassword)
        self.view.addSubview(phoneField)
        self.view.addSubview(passwordField)
        self.view.addSubview(line1)
        self.view.addSubview(line2)
        self.view.addSubview(line3)
        self.view.addSubview(notice)
        self.view.addSubview(submitBtn)
        
        notice.addTarget(self, action: #selector(findPwd), for: .touchUpInside)
        
        submitBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        imgViewOne.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(148)
            make.height.width.snEqualTo(185)
        }
        imgViewTwo.snp.makeConstraints { (make) in
            make.top.equalTo(imgViewOne.snp.bottom).snOffset(22)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(166)
            make.height.snEqualTo(39)
        }
        
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.right.equalToSuperview().snOffset(-75)
            make.height.snEqualTo(1)
            make.top.equalTo(imgViewTwo.snp.bottom).snOffset(147)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.right.equalToSuperview().snOffset(-75)
            make.height.snEqualTo(1)
            make.top.equalTo(line1.snp.bottom).snOffset(111)
        }
        
        imgPhone.snp.makeConstraints { (make) in
            make.left.equalTo(line1.snp.left).snOffset(15)
            make.bottom.equalTo(line1.snp.top).snOffset(-30)
            make.width.snEqualTo(28)
            make.height.snEqualTo(35)
        }
        phoneField.snp.makeConstraints { (make) in
            make.left.equalTo(imgPhone.snp.right).snOffset(42)
            make.centerY.equalTo(imgPhone.snp.centerY)
            make.width.snEqualTo(440)
        }
        imgPassword.snp.makeConstraints { (make) in
            make.left.equalTo(line2.snp.left).snOffset(15)
            make.bottom.equalTo(line2.snp.top).snOffset(-30)
            make.width.snEqualTo(28)
            make.height.snEqualTo(35)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.left.equalTo(imgPassword.snp.right).snOffset(42)
            make.centerY.equalTo(imgPassword.snp.centerY)
            make.width.snEqualTo(440)
        }

        submitBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(75)
            make.right.equalToSuperview().snOffset(-75)
            make.top.equalTo(line2.snp.bottom).snOffset(100)
            make.height.snEqualTo(90)
        }
        
        line3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(217)
            make.right.equalToSuperview().snOffset(-217)
            make.height.snEqualTo(1)
            make.top.equalTo(submitBtn.snp.bottom).snOffset(97)
        }
        
        notice.snp.makeConstraints { (make) in
            make.centerY.equalTo(line3.snp.centerY)
            make.centerX.equalTo(line3.snp.centerX)
            make.width.snEqualTo(130)
        }

    }
}


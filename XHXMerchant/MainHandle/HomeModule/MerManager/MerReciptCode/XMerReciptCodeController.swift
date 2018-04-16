//
//  XMerReciptCodeController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerReciptCodeController: SNBaseViewController {
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(10)
    }
    
    let line1 = UIView().then{
        $0.backgroundColor  = Color(0xe5e5e5)
    }
    
    let noticeOne = UILabel().then{
        $0.text = "扫描二维码向我付款"
        $0.font = Font(36)
        $0.textColor = Color(0x272727)
    }
    
    let codeView = ZJPayErCodeContetnView().then({
        $0.layer.cornerRadius = fit(10)
        
    })
    let noticeTwo = UILabel().then{
        $0.text = "点击二维码保存"
        $0.font = Font(30)
        $0.textColor = Color(0xa19e9e)
    }
    let noticeThree = UILabel().then{
        $0.text = "注：此二维码不绑定员工账号，收款信息不会推送给本店员工"
        $0.font = Font(26)
        $0.textColor = Color(0xffffff)
    }
    
    
    func setUpUI(){
        self.title = "收款码"
        self.view.backgroundColor = ColorRGB(red: 183, green: 174, blue: 0)
        self.codeView.creatErcode()
        
        self.view.addSubview(mainView)
        self.view.addSubview(noticeThree)
        mainView.addSubview(noticeOne)
        mainView.addSubview(line1)
        mainView.addSubview(codeView)
        mainView.addSubview(noticeTwo)
        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(775)
            make.top.equalToSuperview().snOffset(100)
        }
        noticeOne.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(68)
        }
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(noticeOne.snp.bottom).snOffset(58)
            make.left.equalToSuperview().snOffset(10)
            make.right.equalToSuperview().snOffset(-10)
            make.height.snEqualTo(1)
        }
        codeView.snp.makeConstraints { (make) in
            make.top.equalTo(line1.snp.bottom).snOffset(42)
            make.centerX.equalToSuperview()
            make.height.width.snEqualTo(406)
        }
        noticeTwo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeView.snp.bottom).snOffset(82)
        }

        noticeThree.snp.makeConstraints { (make) in
            make.top.equalTo(mainView.snp.bottom).snOffset(36)
            make.centerX.equalToSuperview()
        }

    }
    override func setupView() {
        setUpUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = ColorRGB(red: 183, green: 174, blue: 0)
        (navigationController as! SNBaseNaviController).hindShadowImage()
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0xffffff)]
    }

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.barTintColor = Color(0xffffff)
    (navigationController as! SNBaseNaviController).resetShadowImage()
//    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0x313131)]
    
    }
    
}

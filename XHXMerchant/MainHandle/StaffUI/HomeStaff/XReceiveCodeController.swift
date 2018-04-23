//
//  XReceiveCodeController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/22.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XReceiveCodeController: SNBaseViewController {
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(10)
    }
    
    let noticeOne = UILabel().then{
        $0.text = "员工：陈贱人(xiaoheixiong@qqc)"
        $0.font = Font(30)
        $0.textColor = Color(0x272727)
    }
    
    let codeView = ZJPayErCodeContetnView().then({
        $0.layer.cornerRadius = fit(10)
        
    })
    let noticeTwo = UILabel().then{
        $0.text = "点击二维码保存"
        $0.font = Font(30)
        $0.textColor = Color(0xffffff)
        $0.alpha = 0.4
    }

    let titleView = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.text = "我的收款二维码"
        $0.font = Font(30)
    }
    
    let nameView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let nameLable = UILabel().then{
        $0.text = "陈"
        $0.font = Font(81)
        $0.textColor = Color(0x554dff)
    }
    
    func setUpUI(){
        self.view.backgroundColor = Color(0x554dff)
        navigationItem.titleView = titleView

        self.codeView.creatErcodeStaff()
        
        self.view.addSubview(mainView)
        mainView.addSubview(noticeOne)
        mainView.addSubview(codeView)
        self.view.addSubview(noticeTwo)
        
        
        nameView.frame = CGRect(x:fit(287), y:fit(45), width: fit(178), height: fit(178))
        nameView.addCorner(roundingCorners:UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topRight.rawValue) | UInt8(UIRectCorner.topLeft.rawValue))), cornerSize: CGSize(width: fit(89), height: fit(89)))
        self.view.addSubview(nameView)
        
        nameView.addSubview(nameLable)
        nameLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(37)
        }

        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(60)
            make.right.equalToSuperview().snOffset(-60)
            make.height.snEqualTo(714)
            make.top.equalToSuperview().snOffset(145)
        }
        
        
        noticeOne.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(96)
        }
       
        codeView.snp.makeConstraints { (make) in
            make.top.equalTo(noticeOne.snp.bottom).snOffset(36)
            make.left.equalToSuperview().snOffset(90)
            make.right.equalToSuperview().snOffset(-90)
            make.bottom.equalToSuperview().snOffset(-100)
        }
        noticeTwo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom).snOffset(32)
        }
        
    }
    override func setupView() {
        setUpUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = Color(0x554dff)
        
        (navigationController as! SNBaseNaviController).hindShadowImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0xffffff),NSAttributedStringKey.font:Font(36)]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = Color(0xffffff)
        (navigationController as! SNBaseNaviController).resetShadowImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0x313131),NSAttributedStringKey.font:Font(36)]
        
    }
    
}

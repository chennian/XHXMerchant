//
//  XMerCateController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerCateController: SNBaseViewController {
    fileprivate let merCatePiker = XMerCatePiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))

    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let textfield = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请选择店铺类别"
    }
    
    let submit = UIButton().then{
        $0.setTitle("确定", for:.normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    @objc  func  submitData(){
        let NotifMycation = NSNotification.Name(rawValue:"shopCate")
        NotificationCenter.default.post(name: NotifMycation, object: self.textfield.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func setupView() {
        self.title = "店铺类别"
        view.addSubview(mainView)
        mainView.addSubview(textfield)
        view.addSubview(submit)
        self.textfield.inputView = merCatePiker
        merCatePiker.selectValue = {[unowned self](name,id) in
            self.textfield.text = name
        }
        
        submit.addTarget(self, action: #selector(submitData), for: .touchUpInside)
        
        mainView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(20)
            make.height.snEqualTo(100)
        }
        textfield.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            
        }
        
        submit.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(mainView.snp.bottom).snOffset(96)
            make.height.snEqualTo(100)
        }
        
        submit.addTarget(self, action: #selector(submitData), for: .touchUpInside)
        
    }
    
    
}

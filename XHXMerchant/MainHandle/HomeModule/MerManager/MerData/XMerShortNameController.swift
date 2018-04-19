//
//  XMerShortNameController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerShortNameController: SNBaseViewController {
    
    var block:((_ para:String)->())?

    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let textfield = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入店铺简称"
    }
    
    let submit = UIButton().then{
        $0.setTitle("确定", for:.normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    @objc  func  submitData(){
        guard let action = block else {
            return
        }
        
        if  textfield.text! == "" {
            SZHUD("请填写店铺简称", type: .info, callBack: nil)
            return
        }
        action(textfield.text!)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    override func setupView() {
        view.addSubview(mainView)
        mainView.addSubview(textfield)
        view.addSubview(submit)
        
        mainView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(20)
        }
        textfield.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        submit.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(30)
            make.top.equalTo(mainView.snp.bottom).snOffset(96)
            make.height.snEqualTo(100)
        }
        
        submit.addTarget(self, action: #selector(submitData), for: .touchUpInside)
        
    }
  

}

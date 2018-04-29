//
//  XInputCouponController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/29.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XInputCouponController: SNBaseViewController {

    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let textfield = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入卡劵码"
    }
    
    let submit = UIButton().then{
        $0.setTitle("确定", for:.normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    @objc  func  submitData(){
        if textfield.text! == "" {
            UIAlertView(title: "温馨提示", message: "请输入卡券码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        SNRequestBool(requestType: API.couponCancel(code: textfield.text!)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                for i in 0..<(self.navigationController?.viewControllers.count)! {
                    if self.navigationController?.viewControllers[i].isKind(of: XHomeController.self) == true {
                        _ = self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! XHomeController, animated: true)
                        break
                    }
                }
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
    }
        
       
    override func setupView() {
        self.title = "卡劵验证"
        view.addSubview(mainView)
        mainView.addSubview(textfield)
        view.addSubview(submit)
        
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

//
//  XCouponController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/29.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XCouponController: SNBaseViewController {
    var model:CouponModel?
    
    var code:String = ""
    
    let backView = UIImageView().then{
        $0.image = UIImage(named: "scan_background")
    }
    
    let name = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(36)
    }
    let shopName = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(28)
    }
    let time = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(28)
    }
    
    let button = UIButton().then{
        $0.setTitle("确定核销", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.titleLabel?.font = Font(32)
    }
    @objc func submit(){
        SNRequestBool(requestType: API.couponCancel(code:self.code)).subscribe(onNext: {[unowned self] (result) in
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
        self.title = "扫描结果"
        view.addSubview(backView)
        backView.addSubview(name)
        backView.addSubview(shopName)
        backView.addSubview(time)
        view.addSubview(button)
        
        name.text = model?.name
        shopName.text = model?.shopName
        time.text = model?.terminaltime
        
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(50)
        }
        name.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(82)
            make.top.equalToSuperview().snOffset(49)
        }
        shopName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(82)
            make.top.equalTo(name.snp.bottom).snOffset(25)
        }
        time.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(82)
            make.top.equalTo(shopName.snp.bottom).snOffset(25)
        }
        
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(backView.snp.bottom).snOffset(87)
            make.height.snEqualTo(100)
        }
        
    }
}

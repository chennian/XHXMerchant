//
//  XAddCateController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddCateController: SNBaseViewController {
    
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let textfield = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入商品分类名"
    }
    
    let submit = UIButton().then{
        $0.setTitle("确定", for:.normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
    }
    
    @objc  func  submitData(){
        
        if textfield.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品分类", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let parameters:[String:Any] = ["category_name":textfield.text!,
                                       "shop_id":XKeyChain.get("SHOPID")]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.addCategory(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                self.navigationController?.popViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
     
    }
    override func setupView() {
        self.title = "新增分类"
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
        
        
    }
    
    
}

//
//  XAddMerController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XAddMerController: SNBaseViewController {
    
    var cell :XAddMerCell = XAddMerCell()
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XAddMerCell.self)
        $0.register(XSpaceCell.self)
        $0.register(XOperatorBtnCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "店铺列表"
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    func uploadData(){
        
        if cell.LicenseNameField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请选择营业执照", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if cell.merShortNameField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商户简称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if cell.addressField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入所在区域", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if cell.detailAddressField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入详细地址", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
         let parameters:[String:Any] = ["shopName":cell.LicenseNameField.text!,
                                        "address":cell.addressField.text! + cell.detailAddressField.text!,
                                        "entname":cell.merShortNameField.text!]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.addBranchShop(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
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
        setupUI()
    }
}

extension XAddMerController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XAddMerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.cell = cell
            return cell
        }else{
            let cell:XOperatorBtnCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = {[unowned self] () in
                self.uploadData()
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return fit(20)
        }else if indexPath.row == 1{
            return fit(362)

        }else{
            return fit(360)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
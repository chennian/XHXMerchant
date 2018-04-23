//
//  XMerAddStaffController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerAddStaffController:SNBaseViewController {
    var model:XMerStaffList?
    var cell :XMerAddStaffCell = XMerAddStaffCell()
    var shop_id:String = ""
    var temp:String = ""
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMerAddStaffCell.self)
        $0.register(XSpaceCell.self)
        $0.register(XOperatorBtnCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "添加员工"
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        if temp == "1" {
            setNavigationBar()
        }
    }
    @objc func deleteStaff(){
        SNRequestBool(requestType: API.deleteShopEmployee(id:(self.model?.id)!, shopId:self.shop_id)).subscribe(onNext: {[unowned self] (result) in
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
    
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "删除", imgName:"", target: self, action: #selector(deleteStaff))
        navigationItem.rightBarButtonItem = barbutton
    }
    
    func editData(){
        
        if self.shop_id == ""{
            UIAlertView(title: "温馨提示", message: "店铺不存在", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if cell.staffNameField.text == ""{
            UIAlertView(title: "温馨提示", message: "请输入员工名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if cell.staffAccountField.text == ""{
            UIAlertView(title: "温馨提示", message: "请输入员工账号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if cell.passwordField.text == ""{
            UIAlertView(title: "温馨提示", message: "请输入员工密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        CNLog(shop_id)
        let paremeters:[String:Any] = ["shopId":self.shop_id,
                                       "names":cell.staffNameField.text!,
                                       "employee":cell.staffAccountField.text!,
                                       "password":cell.passwordField.text!]
        
        SNRequestBool(requestType: API.shopEditEmployee(paremeter: paremeters)).subscribe(onNext: {[unowned self] (result) in
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
    func uploadData(){
        
        if self.shop_id == ""{
            UIAlertView(title: "温馨提示", message: "店铺不存在", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if cell.staffNameField.text == ""{
             UIAlertView(title: "温馨提示", message: "请输入员工名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if cell.staffAccountField.text == ""{
            UIAlertView(title: "温馨提示", message: "请输入员工账号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if cell.passwordField.text == ""{
            UIAlertView(title: "温馨提示", message: "请输入员工密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        CNLog(shop_id)
        let paremeters:[String:Any] = ["shopId":self.shop_id,
                                       "names":cell.staffNameField.text!,
                                       "employee":cell.staffAccountField.text!,
                                       "password":cell.passwordField.text!]
        
        SNRequestBool(requestType: API.shopAddEmployee(paremeter: paremeters)).subscribe(onNext: {[unowned self] (result) in
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)       
    }

}

extension XMerAddStaffController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XMerAddStaffCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.cell = cell
            cell.staffNameField.text = model?.names
            cell.staffAccountField.text = model?.employee
            cell.passwordField.text = model?.password
            return cell
        }else{
            let cell:XOperatorBtnCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = {[unowned self] () in
                if self.temp == "1"{
                    self.editData()
                }else{
                    self.uploadData()
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return fit(20)
        }else if indexPath.row == 1{
            return fit(271)
            
        }else{
            return fit(360)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

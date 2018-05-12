//
//  XMerPushSwitchController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerPushSwitchController: SNBaseViewController {
    
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XPushSwitchCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "收益信息推送开关"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    func getData(){
        
        let parameters:[String:Any] = ["mobile":"",
                                       "merchant":"",
                                       "flowmeter":"",
                                       "service":"",
                                       "operator":"",
                                       "corporation":"",
                                       "employee":""]
        
        SNRequestBool(requestType: API.setPushSwitch(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                SZHUD("上传成功", type: .info, callBack: nil)
            case .fail(let code,let res):
                SZHUD(res ?? "上传失败", type: .error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        //        getData()
        setupUI()
    }
}

extension XMerPushSwitchController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XPushSwitchCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.pushSwitch.tag = 1
            if XKeyChain.get("corporation") == "1"{
                cell.pushSwitch.isOn = true
            }else{
                cell.pushSwitch.isOn = false
            }
            cell.name.text = "服务中心"
            cell.clickEvent = {[unowned self] (sender) in
                if sender.isOn {
                    XKeyChain.set("1", key: "corporation")
                }else{
                    XKeyChain.set("0", key: "corporation")
                }
            }
            return cell
        }else if indexPath.row == 2{
            let cell:XPushSwitchCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if XKeyChain.get("operator") == "1"{
                cell.pushSwitch.isOn = true
            }else{
                cell.pushSwitch.isOn = false
            }
            cell.name.text = "运营商"
            cell.pushSwitch.tag = 2
            cell.clickEvent = {[unowned self] (sender) in
                if sender.isOn {
                    XKeyChain.set("1", key: "operator")
                }else{
                    XKeyChain.set("0", key: "operator")
                }
            }
            return cell
        }else if indexPath.row == 3{
            let cell:XPushSwitchCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if XKeyChain.get("service") == "1"{
                cell.pushSwitch.isOn = true
            }else{
                cell.pushSwitch.isOn = false
            }
            cell.name.text = "服务商"
            cell.pushSwitch.tag = 3
            cell.clickEvent = {[unowned self] (sender) in
                if sender.isOn {
                    XKeyChain.set("1", key: "service")
                }else{
                    XKeyChain.set("0", key: "service")
                }
            }
            return cell
        }else if indexPath.row == 4{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

            return cell
        }else if indexPath.row == 5{
            let cell:XPushSwitchCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if XKeyChain.get("merchant") == "1"{
                cell.pushSwitch.isOn = true
            }else{
                cell.pushSwitch.isOn = false
            }
            cell.name.text = "商家货款"
            cell.pushSwitch.tag = 4
            cell.clickEvent = {[unowned self] (sender) in
                if sender.isOn {
                    XKeyChain.set("1", key: "merchant")
                }else{
                    XKeyChain.set("0", key: "merchant")
                }
            }
            
            return cell
        }else{
            let cell:XPushSwitchCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if XKeyChain.get("flowmeter") == "1"{
                cell.pushSwitch.isOn = true
            }else{
                cell.pushSwitch.isOn = false
            }
            cell.name.text = "商家导流"
            cell.pushSwitch.tag = 5
            cell.clickEvent = {[unowned self] (sender) in
                if sender.isOn {
                    XKeyChain.set("1", key: "flowmeter")
                }else{
                    XKeyChain.set("0", key: "flowmeter")
                }            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(30)
        }else if indexPath.row == 4{
            return fit(20)
        }else{
            return fit(111)
        }
    }
    
}

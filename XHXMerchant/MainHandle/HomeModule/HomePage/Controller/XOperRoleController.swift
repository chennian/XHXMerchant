//
//  XRoleController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XOperRoleController: SNBaseViewController {

    
    fileprivate var operatorCell:XUpdateOperCell = XUpdateOperCell()

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XUpdateOperCell.self)
        $0.register(XSpaceCell.self)

        $0.separatorStyle = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func submit(){
        
        if operatorCell.codeLableField.text! == ""{
              UIAlertView(title: "温馨提示", message: "请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        SNRequestBool(requestType: API.upgrade0perator(verifycode:operatorCell.codeLableField.text!)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                SZHUD("上传成功", type: .success, callBack: nil)
                self.navigationController?.popToRootViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
        
        
    }
    func sendSMS(){
        SNRequestBool(requestType: API.sendSMS(mobile:XKeyChain.get(PHONE),vtype:"3")).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                SZHUD("发送成功", type: SZHUDType.success, callBack: nil)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: self.disposeBag)
    }
    
    fileprivate func setupUI() {
        
        self.title = "升级运营商"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}
extension XOperRoleController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:XUpdateOperCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        self.operatorCell = cell
        cell.timeButton.clickBtnEvent = {[unowned self] () in
            self.sendSMS()
        }
        cell.clickEvent = {[unowned self] () in
            //提交
            self.submit()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return fit(1206)
    }
    
}

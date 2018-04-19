//
//  XRecmdServiceController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XRecmdServiceController: SNBaseViewController {
    
    fileprivate var operatorCell:XServiceTopCell = XServiceTopCell()
    fileprivate var operEndCell:XOperatorEndCell = XOperatorEndCell()
    
    fileprivate let bankPiker = bankCardPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
    
    var bankName:String = ""
    var bankId:String = ""
    
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XServiceTopCell.self)
        $0.register(XOperatorEndCell.self)
        $0.register(XOperatorBtnCell.self)
        $0.register(XSpaceCell.self)
        
        $0.separatorStyle = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    fileprivate func setupUI() {
        
        self.title = "推荐服务商"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    //提交数据
    func upLoad(){
        if operatorCell.accountField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入被推荐人手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operatorCell.codeLableField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operatorCell.activieLableField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入激活码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operEndCell.realNameField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入真实姓名", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operEndCell.IDNumField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入银行卡号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operEndCell.bankNumField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入银行卡号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operEndCell.cardbankField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入开卡银行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if operEndCell.branchLableField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入开户支行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        let parameters:[String:Any] =
            ["activatecode":operatorCell.activieLableField.text!,
             "user_phone":operatorCell.accountField.text!,
             "verifycode":operatorCell.codeLableField.text!,
             "real_name":operEndCell.realNameField.text!,
             "real_card":operEndCell.IDNumField.text!,
             "bank_num":operEndCell.bankNumField.text!,
             "bank_id":self.bankId,
             "bank_name":operEndCell.cardbankField.text!,
             "subbranch":operEndCell.branchLableField.text!]
        
        CNLog(parameters)
        SNRequestBool(requestType: API.recommendService(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
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
        if self.operatorCell.accountField.text! == "" {
            UIAlertView(title: "温馨提示", message:"请输入被推荐人手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        CNLog(self.operatorCell.accountField.text!)
        SNRequestBool(requestType: API.sendSMS(mobile: self.operatorCell.accountField.text!,vtype:"7")).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                SZHUD("发送成功", type: SZHUDType.success, callBack: nil)
            case .fail(let code,let res):
                SZHUD(res ?? "上传失败", type: .error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: self.disposeBag)
    }
}
extension XRecmdServiceController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XServiceTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.operatorCell = cell
            
            cell.timeButton.clickBtnEvent = {[unowned self] in
                self.sendSMS()
            }
            
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XOperatorEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.operEndCell = cell
            cell.cardbankField.inputView = bankPiker
            bankPiker.selectValue = {[unowned self] (name,id) in
                self.operEndCell.cardbankField.text = name
                self.bankName = name
                self.bankId = id
            }
            return cell
        }else if indexPath.row == 4{
            let cell:XOperatorBtnCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = {[unowned self] () in
                self.upLoad()
            }
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return fit(362)
        }else if indexPath.row == 3{
            return fit(453)
        }else if indexPath.row == 4{
            return fit(445)
        }else{
            return fit(20)
        }
        
    }
    
}

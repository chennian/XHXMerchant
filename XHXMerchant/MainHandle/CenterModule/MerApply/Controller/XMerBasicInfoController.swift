//
//  XMerBasicInfoController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerBasicInfoController: SNBaseViewController {
    
    fileprivate var fieldCell:XBasicInfoFieldCell = XBasicInfoFieldCell()
    fileprivate var accountName :String?
    fileprivate var legalName :String?
    fileprivate var idCard :String?
    fileprivate var emergencyContact :String?
    fileprivate var emergencyContactPhone :String?
    fileprivate var email :String?
    var stepOneModel: StepOneProtocol?
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XBasicInfoFieldCell.self)
        $0.register(XButtonCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    override func setupView() {
        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard  let oneStep = stepOneModel  else {
            return
        }
        fieldCell.accountNameField.text = oneStep.accountName
        fieldCell.legalNameField.text = oneStep.legalName
        fieldCell.idCardTextField.text = oneStep.idCard
        fieldCell.emergencyContactField.text = oneStep.emergencyContact
        fieldCell.emergencyContactPhoneField.text = oneStep.emergencyContactPhone
        fieldCell.emailField.text = oneStep.email
    
    }
    func saveModel(){
        accountName = fieldCell.accountNameField.text
        legalName =  fieldCell.legalNameField.text
        idCard = fieldCell.idCardTextField.text
        emergencyContact = fieldCell.emergencyContactField.text
        emergencyContactPhone = fieldCell.emergencyContactPhoneField.text
        email = fieldCell.emailField.text
        
        self.stepOneModel?.accountName = accountName
        self.stepOneModel?.legalName = legalName
        self.stepOneModel?.idCard = idCard
        self.stepOneModel?.emergencyContact = emergencyContact
        self.stepOneModel?.emergencyContactPhone = emergencyContactPhone
        self.stepOneModel?.email = email
        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)


    }
    fileprivate func setupUI() {
        stepOneModel = ApplyModel.shareApplyModel.applySelfModel.stepOne
        self.title = "基本信息"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }

}
extension XMerBasicInfoController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XBasicInfoFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.fieldCell = cell
            return cell
        }else{
            let cell:XButtonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.submitBoutton.setTitle("下一步", for: .normal)
            cell.clickBtnEvent = {[unowned self](parameter) in
                self.saveModel()
                SNLog("保存成功")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(545)
        }else{
            return fit(120)
        }
    }
    
}

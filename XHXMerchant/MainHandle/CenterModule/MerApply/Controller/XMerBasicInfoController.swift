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
    fileprivate var oneStep:StepOne?

//    var stepOneModel: StepOneProtocol?

    fileprivate var path: String {
        get {
            let filename = "/archive"
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            return "\(documentDirectory)\(filename)"
        }
    }
    
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
        oneStep = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? StepOne
        fieldCell.accountNameField.text = oneStep!.accountName
        fieldCell.legalNameField.text = oneStep!.legalName
        fieldCell.idCardTextField.text = oneStep!.idCard
        fieldCell.emergencyContactField.text = oneStep!.emergencyContact
        fieldCell.emergencyContactPhoneField.text = oneStep!.emergencyContactPhone
        fieldCell.emailField.text = oneStep!.email
    
    }
    func saveModel(){
        self.accountName = fieldCell.accountNameField.text
        self.legalName =  fieldCell.legalNameField.text
        self.idCard = fieldCell.idCardTextField.text
        self.emergencyContact = fieldCell.emergencyContactField.text
        self.emergencyContactPhone = fieldCell.emergencyContactPhoneField.text
        self.email = fieldCell.emailField.text

        let oneStepArchive = StepOne.init(accountName!,legalName!,idCard!,emergencyContact!,emergencyContactPhone!,email!)
         NSKeyedArchiver.archiveRootObject(oneStepArchive, toFile: self.path)
        CNLog(oneStep?.accountName)

    }
    fileprivate func setupUI() {
//        stepOneModel = ApplyModel.shareApplyModel.applySelfModel.stepOne
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

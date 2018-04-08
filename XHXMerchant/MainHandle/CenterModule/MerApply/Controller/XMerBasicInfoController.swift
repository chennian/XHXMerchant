//
//  XMerBasicInfoController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/6.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import TZImagePickerController

class XMerBasicInfoController: SNBaseViewController {
    
    fileprivate var fieldCell:XBasicInfoFieldCell = XBasicInfoFieldCell()
    fileprivate var imgCell:XIdCardImageCell = XIdCardImageCell()
    fileprivate var accountName :String?
    fileprivate var legalName :String?
    fileprivate var idCard :String?
    fileprivate var emergencyContact :String?
    fileprivate var emergencyContactPhone :String?
    fileprivate var email :String?
    
    fileprivate var frontImagePath:String = ""
    fileprivate var backImagePath:String = ""

    var stepOneModel: StepOneProtocol?
    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XBasicInfoFieldCell.self)
        $0.register(XIdCardImageCell.self)
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
        
        imgCell.frontCard.setImage(oneStep.frontImage?.image, for: UIControlState.normal)
        imgCell.backCard.setImage(oneStep.backImage?.image, for: UIControlState.normal)

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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XBasicInfoFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.fieldCell = cell
            return cell
        }else if indexPath.row == 1{
            let cell:XIdCardImageCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.imgCell = cell
            cell.imgTap.subscribe(onNext: {[unowned self] (btn,fullname) in
                self.fullName = fullname
                self.protocolObject = btn
                let alertView = DDZCamerationController()
                let picker = DDZImagePickerVC()
                picker.delegate = self
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                        picker.sourceType = .camera
                        self.present(picker, animated: true, completion: nil)
                    })
                    alertView.addAction(action)
                }
                
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                        picker.sourceType = .savedPhotosAlbum
                        self.present(picker, animated: true, completion: nil)
                        
                    })
                    alertView.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
            }).disposed(by: cell.disposeBag)
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
        }else if indexPath.row == 1{
            return fit(690)
        }else{
            return fit(120)
        }
    }
    
}

extension XMerBasicInfoController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        cropVC.customAspectRatio = CGSize(width:1,height:1)
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension  XMerBasicInfoController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    if self.fullName == "img1"{
                        self.frontImagePath = frontUrl + obk
                        self.stepOneModel?.frontImage = ApplyImage(image: image, path: self.frontImagePath)
                    }else{
                        self.backImagePath = frontUrl + obk
                        self.stepOneModel?.backImage = ApplyImage(image: image, path: self.backImagePath)
                    }
                    
                }
            })
            
        }
        
    }
}



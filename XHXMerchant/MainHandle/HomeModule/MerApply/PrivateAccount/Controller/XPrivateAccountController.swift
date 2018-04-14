//
//  XPrivateAccountController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

import TOCropViewController
import TZImagePickerController

class XPrivateAccountController: SNBaseViewController {
    fileprivate var fieldCell:XPrivateAccountFieldCell = XPrivateAccountFieldCell()
    fileprivate var imgCell:XPrivateAccountImgCell = XPrivateAccountImgCell()
    
    var stepThreeModel: StepThreeProtocol?
    
    var protocolObject : AliOssTransferProtocol?
    
    fileprivate var cardImagePath:String = ""
    
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XPrivateAccountFieldCell.self)
        $0.register(XPrivateAccountImgCell.self)
        $0.register(XButtonCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    fileprivate func setupUI() {
        stepThreeModel = ApplyModel.shareApplyModel.applySelfModel.stepThree
        
        self.title = "对私账户信息"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func saveModel(){
        
        self.stepThreeModel?.privateBankAccount = fieldCell.privateBankAccountField.text
        self.stepThreeModel?.privateBank = fieldCell.privateBankField.text
        self.stepThreeModel?.privateBankAddress = fieldCell.privateBankAddressField.text
        self.stepThreeModel?.branchName = fieldCell.branchNameField.text
        self.stepThreeModel?.privatebankName = fieldCell.privatebankNameField.text
        self.stepThreeModel?.leftMobile = fieldCell.leftMobileField.text
        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
        
    }
    override func setupView() {
        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard  let threeStep = stepThreeModel  else {
            return
        }
        fieldCell.privateBankAccountField.text = threeStep.privateBankAccount
        fieldCell.privateBankField.text = threeStep.privateBank
        fieldCell.privateBankAddressField.text = threeStep.privateBankAddress
        fieldCell.branchNameField.text = threeStep.branchName
        fieldCell.privatebankNameField.text = threeStep.privatebankName
        fieldCell.leftMobileField.text = threeStep.leftMobile
        
        if threeStep.permitCard?.image == nil {
            imgCell.bankCard.setImage(UIImage(named:"bank_card"), for: .normal)
        }else{
            imgCell.bankCard.setImage(threeStep.frontCard?.image, for: UIControlState.normal)
        }
        
    }
}
extension XPrivateAccountController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XPrivateAccountFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            fieldCell = cell
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XPrivateAccountImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.imgCell = cell
            cell.imgTap.subscribe(onNext: {[unowned self] (btn) in
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
                
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(20)
        }else if indexPath.row == 1 {
            return fit(713)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(497)
        }else{
            return fit(239)
        }
    }
    
}
extension XPrivateAccountController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        cropVC.customAspectRatio = CGSize(width:fit(483),height:fit(260))
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension  XPrivateAccountController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传图片中", type:.loading, callBack: nil)
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    self.cardImagePath = frontUrl + obk
                    self.stepThreeModel?.frontCard = ApplyImage(image: image, path: self.cardImagePath)
                    self.imgCell.bankCard.setImage(image, for: .normal)
                    
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}




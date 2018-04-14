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
    fileprivate var registName :String?
    fileprivate var principal :String?
    fileprivate var principalPhone :String?
    fileprivate var idCard :String?
    fileprivate var validity :String?
    
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
        fieldCell.registNameField.text = oneStep.registName
        fieldCell.principalField.text = oneStep.principal
        fieldCell.principalPhoneField.text = oneStep.principalPhone
        fieldCell.idCardField.text = oneStep.idCard
        fieldCell.validityField.text = oneStep.validity
        CNLog(oneStep.frontImage?.image)
        
        if oneStep.frontImage?.image == nil {
            imgCell.frontCard.setImage(UIImage(named:"papers_front"), for: .normal)
        }else{
            imgCell.frontCard.setImage(oneStep.frontImage?.image, for: UIControlState.normal)
//            imgCell.frontCard.kf.setImage(with: URL(string: (oneStep.frontImage?.path)!), for: .normal)

        }
        if oneStep.backImage?.image == nil {
            imgCell.backCard.setImage(UIImage(named:"papers_contrary"), for: .normal)
        }else{
            imgCell.backCard.setImage(oneStep.backImage?.image, for: UIControlState.normal)
//            imgCell.frontCard.kf.setImage(with: URL(string: (oneStep.backImage?.path)!), for: .normal)

        }
        
        
    }
    func saveModel(){
        registName = fieldCell.registNameField.text
        principal =  fieldCell.principalField.text
        principalPhone = fieldCell.principalPhoneField.text
        idCard = fieldCell.idCardField.text
        validity = fieldCell.validityField.text
        
        self.stepOneModel?.registName = registName
        self.stepOneModel?.principal = principal
        self.stepOneModel?.principalPhone = principalPhone
        self.stepOneModel?.idCard = idCard
        self.stepOneModel?.validity = validity
        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)


    }
    fileprivate func setupUI() {
        stepOneModel = ApplyModel.shareApplyModel.applySelfModel.stepOne
        self.title = "负责人信息"
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
//                self.saveModel()
                self.navigationController?.pushViewController(XMerLicenseController(), animated: true)
                SNLog("保存成功")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(530)
        }else if indexPath.row == 1{
            return fit(896)
        }else{
            return fit(254)
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
        cropVC.customAspectRatio = CGSize(width:fit(483),height:fit(260))
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension  XMerBasicInfoController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传图片中", type:.loading, callBack: nil)
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    if self.fullName == "img1"{
                        self.frontImagePath = frontUrl + obk
                        self.stepOneModel?.frontImage = ApplyImage(image: image, path: self.frontImagePath)
                        self.imgCell.frontCard.setImage(image, for: .normal)
                    }else{
                        self.backImagePath = frontUrl + obk
                        self.stepOneModel?.backImage = ApplyImage(image: image, path: self.backImagePath)
                        self.imgCell.backCard.setImage(image, for: .normal)
                    }
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}


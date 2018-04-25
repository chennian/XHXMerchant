//
//  XMerLicenseController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/12.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import TZImagePickerController
import SwiftyJSON


class XMerLicenseController: SNBaseViewController {
    fileprivate var fieldCell:XMerLicenseFieldCell = XMerLicenseFieldCell()
    fileprivate var imgCell:XMerLicenseImgCell = XMerLicenseImgCell()
    
//    var provinceArray:[String] = []
//    var cityArray:[String] = []
//    var countyArray:[String] = []
//
//    var provinceString:String = ""
//    var cityString:String = ""
//    var countyString:String = ""
//
//    var jsonArr:JSON = []
    
    var counrentRow:Int = 0
    
    var stepTwoModel: StepTwoProtocol?

    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    
    fileprivate var LicenseImagePath:String = ""
    fileprivate var doorImagePath:String = ""
    fileprivate var checkstandPath:String = ""
    fileprivate var indoorImagePath:String = ""
    fileprivate var indoorImagePath1:String = ""

    fileprivate var province:String = ""
    fileprivate var city:String = ""
    fileprivate var county:String = ""

    
    fileprivate let addressPiker = AddressPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
    fileprivate let industyPiker = IndustyPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMerLicenseFieldCell.self)
        $0.register(XMerLicenseImgCell.self)
        $0.register(XButtonCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    fileprivate func setupUI() {
        stepTwoModel = ApplyModel.shareApplyModel.applySelfModel.stepTwo

        self.title = "商家执照信息"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }

    }
    
    func saveModel(){
        CNLog(self.province +  self.city + self.county)

        self.stepTwoModel?.merShortName = fieldCell.merShortNameField.text
        self.stepTwoModel?.licenseName = fieldCell.licenseNameField.text
        self.stepTwoModel?.licenseTerm = fieldCell.licenseTermField.text
        self.stepTwoModel?.codeNum = fieldCell.codeNumField.text
        self.stepTwoModel?.area = fieldCell.areaField.text
        self.stepTwoModel?.detailAddress = fieldCell.detailAddressField.text
        self.stepTwoModel?.industryType = fieldCell.industryTypeField.text
     

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
        fieldCell.areaField.delegate = self

        guard  let twoStep = stepTwoModel  else {
            return
        }
        
        fieldCell.merShortNameField.text = twoStep.merShortName
        fieldCell.licenseNameField.text = twoStep.licenseName
        fieldCell.licenseTermField.text = twoStep.licenseTerm
        fieldCell.codeNumField.text = twoStep.codeNum
        fieldCell.areaField.text = twoStep.area
        fieldCell.detailAddressField.text = twoStep.detailAddress
        fieldCell.industryTypeField.text = twoStep.industryType
        
        
        if twoStep.LicenseImage?.image == nil {
            imgCell.LicenseImage.setImage(UIImage(named:"business_license"), for: .normal)
        }else{
            imgCell.LicenseImage.setImage(twoStep.LicenseImage?.image, for: UIControlState.normal)
        }
        if twoStep.doorImage?.image == nil {
            imgCell.doorImage.setImage(UIImage(named:"appearance"), for: .normal)
        }else{
            imgCell.doorImage.setImage(twoStep.doorImage?.image, for: UIControlState.normal)
        }
        if twoStep.checkstand?.image == nil {
            imgCell.checkstandImage.setImage(UIImage(named:"cashier_desk"), for: .normal)
        }else{
            imgCell.checkstandImage.setImage(twoStep.checkstand?.image, for: UIControlState.normal)
        }
        if twoStep.indoorImage?.image == nil {
            imgCell.indoorImage.setImage(UIImage(named:"shop_inside"), for: .normal)
        }else{
            imgCell.indoorImage.setImage(twoStep.indoorImage?.image, for: UIControlState.normal)
        }
        if twoStep.indoorImage1?.image == nil {
            imgCell.indoorImage1.setImage(UIImage(named:"shop_inside"), for: .normal)
        }else{
            imgCell.indoorImage1.setImage(twoStep.indoorImage1?.image, for: UIControlState.normal)
        }
        if twoStep.term == "1" || twoStep.term == nil{
            fieldCell.longBtn.isSelected = true
            fieldCell.shortBtn.isSelected = false
            
        }else{
            fieldCell.shortBtn.isSelected = true
            fieldCell.longBtn.isSelected = false
        }
    }
}
extension XMerLicenseController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            fieldCell.block = {[unowned self] (para) in
                self.stepTwoModel?.term = para
                CNLog( self.stepTwoModel?.term)
            }
            return cell
        }else if indexPath.row == 1{
            let cell:XMerLicenseFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            fieldCell = cell
            fieldCell.areaField.inputView = addressPiker
            addressPiker.selectValue = {[unowned self] (string,province,city,county) in
                self.fieldCell.areaField.text = string
                self.province = province
                self.city = city
                self.county = county
                
                self.stepTwoModel?.province = self.province
                self.stepTwoModel?.city = self.city
                self.stepTwoModel?.county = self.county
                ApplyModelTool.save(model: ApplyModel.shareApplyModel)

            }
            
            fieldCell.industryTypeField.inputView = industyPiker
            industyPiker.selectValue = {[unowned self] (string,id) in
                self.fieldCell.industryTypeField.text = string
                
                self.stepTwoModel?.industryID = "\(id)"
                ApplyModelTool.save(model: ApplyModel.shareApplyModel)
            }
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XMerLicenseImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
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
              self.verifyValue()
            }
            return cell
        }
    }
    
    func verifyValue(){
        if fieldCell.merShortNameField.text == ""{
            UIAlertView(title: "提示", message: "请输入商户简称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.licenseNameField.text == ""{
            UIAlertView(title: "提示", message: "请输入营业执照名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if !fieldCell.longBtn.isSelected {
            UIAlertView(title: "提示", message: "请输入营业执照有效期", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
//        if fieldCell.licenseTermField.text == ""{
//            UIAlertView(title: "提示", message: "请输入营业执照有效期", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
//            return
//        }
        if fieldCell.codeNumField.text == ""{
            UIAlertView(title: "提示", message: "请输入统一社会信用代码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.areaField.text == ""{
            UIAlertView(title: "提示", message: "请输入所在区域", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.detailAddressField.text == ""{
            UIAlertView(title: "提示", message: "请输入详细地址", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.industryTypeField.text == ""{
            UIAlertView(title: "提示", message: "请输入行业类别", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepTwoModel?.LicenseImage == nil {
            UIAlertView(title: "提示", message: "请上传营业执照", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepTwoModel?.doorImage == nil {
            UIAlertView(title: "提示", message: "请上传门头照照片", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepTwoModel?.checkstand == nil {
            UIAlertView(title: "提示", message: "请上传收营台照片", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepTwoModel?.indoorImage == nil {
            UIAlertView(title: "提示", message: "请上传店内照片", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepTwoModel?.indoorImage1 == nil {
            UIAlertView(title: "提示", message: "请上传第二张店内照片", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if XKeyChain.get(isConpany) == "1"{
            //1:企业
            self.navigationController?.pushViewController(XPrivateAccountController(), animated: true)

//            self.navigationController?.pushViewController(XOpenAccountController(), animated: true)
        }else{
            self.navigationController?.pushViewController(XPrivateAccountController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(20)
        }else if indexPath.row == 1 {
            return fit(706)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(2021)
        }else{
            return fit(254)
        }
    }
    
}
extension XMerLicenseController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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

extension  XMerLicenseController: TOCropViewControllerDelegate{
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
                        self.LicenseImagePath = frontUrl + obk
                        self.stepTwoModel?.LicenseImage = ApplyImage(image: image, path: self.LicenseImagePath)
                        self.imgCell.LicenseImage.setImage(image, for: .normal)
                    }else if self.fullName == "img2"{
                        self.doorImagePath = frontUrl + obk
                        self.stepTwoModel?.doorImage = ApplyImage(image: image, path: self.doorImagePath)
                        self.imgCell.doorImage.setImage(image, for: .normal)
                    }else if self.fullName == "img3"{
                        self.checkstandPath = frontUrl + obk
                        self.stepTwoModel?.checkstand = ApplyImage(image: image, path: self.checkstandPath)
                        self.imgCell.checkstandImage.setImage(image, for: .normal)
                    }else if self.fullName == "img4"{
                        self.indoorImagePath = frontUrl + obk
                        self.stepTwoModel?.indoorImage = ApplyImage(image: image, path: self.indoorImagePath)
                        self.imgCell.indoorImage.setImage(image, for: .normal)
                    }else{
                        self.indoorImagePath1 = frontUrl + obk
                        self.stepTwoModel?.indoorImage1 = ApplyImage(image: image, path: self.indoorImagePath1)
                        self.imgCell.indoorImage1.setImage(image, for: .normal)
                    }
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}
extension XMerLicenseController:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("我正在编辑状态中...")
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("我即将编辑结束...")
        return true
    }
    
}

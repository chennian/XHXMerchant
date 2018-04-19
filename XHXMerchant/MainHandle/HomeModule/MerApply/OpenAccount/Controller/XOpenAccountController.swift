//
//  XOpenAccountController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/13.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import TZImagePickerController

class XOpenAccountController: SNBaseViewController {
    fileprivate var fieldCell:XOpenAccountFieldCell = XOpenAccountFieldCell()
    fileprivate var imgCell:XOpenAccountImgCell = XOpenAccountImgCell()
    
    var stepThreeModel: StepThreeProtocol?
    
    var protocolObject : AliOssTransferProtocol?
    
    fileprivate var permitImagePath:String = ""
    
    fileprivate var bankProvince:String = ""
    fileprivate var bankCity:String = ""
    fileprivate var bankCounty:String = ""

    fileprivate let addressPiker = AddressPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))

    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XOpenAccountFieldCell.self)
        $0.register(XOpenAccountImgCell.self)
        $0.register(XButtonCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    fileprivate func setupUI() {
        stepThreeModel = ApplyModel.shareApplyModel.applySelfModel.stepThree
        
        self.title = "对公账户信息"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func saveModel(){
        
        self.stepThreeModel?.openBankAccount = fieldCell.openBankAccountField.text
        self.stepThreeModel?.openBank = fieldCell.openBankField.text
        self.stepThreeModel?.openBankAddress = fieldCell.openBankAddressField.text
        self.stepThreeModel?.branchnName = fieldCell.branchnNameField.text
        self.stepThreeModel?.openbankName = fieldCell.openbankNameField.text
        self.stepThreeModel?.leftPhone = fieldCell.leftPhoneField.text
        self.stepThreeModel?.bankProvince = self.bankProvince
        self.stepThreeModel?.bankCity = self.bankCity
        self.stepThreeModel?.bankCounty = self.bankCounty

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
        fieldCell.openBankAccountField.text = threeStep.openBankAccount
        fieldCell.openBankField.text = threeStep.openBank
        fieldCell.openBankAddressField.text = threeStep.openBankAddress
        fieldCell.branchnNameField.text = threeStep.branchnName
        fieldCell.openbankNameField.text = threeStep.openbankName
        fieldCell.leftPhoneField.text = threeStep.leftPhone
        
        if threeStep.permitCard?.image == nil {
            imgCell.permitCard.setImage(UIImage(named:"prove"), for: .normal)
        }else{
            imgCell.permitCard.setImage(threeStep.permitCard?.image, for: UIControlState.normal)
        }
    }
}
extension XOpenAccountController:UITableViewDelegate,UITableViewDataSource{
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
            let cell:XOpenAccountFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            fieldCell = cell
            fieldCell.openBankAddressField.inputView = addressPiker
            addressPiker.selectValue = {[unowned self] (string,province,city,county) in
                self.fieldCell.openBankAddressField.text = string
                self.bankProvince = province
                self.bankCity = city
                self.bankCounty = county
            }
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XOpenAccountImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
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
                if XKeyChain.get(isConpany) == "0"{
                    //0:企业
                    self.navigationController?.pushViewController(XPrivateAccountController(), animated: true)
                }else{
                    self.verifyValue()
                }
            }
            return cell
        }
    }
    
    func verifyValue(){
        if fieldCell.openBankAccountField.text == ""{
            UIAlertView(title: "提示", message: "请输入对公银行账号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.openBankField.text == ""{
            UIAlertView(title: "提示", message: "请输入开户行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.openBankAddress.text == ""{
            UIAlertView(title: "提示", message: "请输入开户行坐在地", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.branchnNameField.text == ""{
            UIAlertView(title: "提示", message: "请输入支行名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.openbankNameField.text == ""{
            UIAlertView(title: "提示", message: "请输入银行开户名", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.leftPhoneField.text == ""{
            UIAlertView(title: "提示", message: "请输入预留手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }

        if stepThreeModel?.permitCard == nil {
            UIAlertView(title: "提示", message: "请上传开户许可证", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        uploadData()
        //        self.navigationController?.pushViewController(XMerLicenseController(), animated: true)
        
    }
    
    
    func uploadData(){
        //获取第一步资料
        let stepOneItem = ApplyModel.shareApplyModel.applySelfModel.stepOne
        let cardtype:String =  XKeyChain.get(isConpany) //公司类型 0：个体 1：公司
        let name :String = stepOneItem.principal ?? ""  //负责人姓名
        let phone: String = stepOneItem.principalPhone ?? "" //负责人电话
        let registerPhone: String = stepOneItem.registName ?? "" //注册手机号
        let idCard: String = stepOneItem.idCard ?? ""  //证件号码
        let validity: String = stepOneItem.validity ?? "" //证件有效期
        let idcardone: String = stepOneItem.frontImage?.path ?? "" //正面照
        let idcardtwo: String = stepOneItem.backImage?.path ?? ""  //反面照
        
        //获取第二步资料
        let stepSecondeItem = ApplyModel.shareApplyModel.applySelfModel.stepTwo
        
        let entabb: String = stepSecondeItem.merShortName ?? ""  //企业简称
        let entname: String = stepSecondeItem.licenseName ?? ""  //企业名称
        let busregnum: String = stepSecondeItem.codeNum ?? ""  //统一社会信用代码
        let enterpraiseLicenseTerm: String = stepSecondeItem.licenseTerm ?? "" // 营业执照有效期
        let details: String = stepSecondeItem.detailAddress ?? ""    // 详细地址
        let industryid: String = stepSecondeItem.industryType ?? ""  // 商家类型
        let province: String = stepSecondeItem.province ?? ""  //省
        let city: String = stepSecondeItem.city ?? ""          //市
        let area: String = stepSecondeItem.county ?? ""        //区
        
        
        let busregimg: String = stepSecondeItem.LicenseImage?.path ?? ""  //反面照
        let gatepic: String = stepSecondeItem.doorImage?.path ?? ""  //反面照
        let checkStandPic: String = stepSecondeItem.checkstand?.path ?? ""  //反面照
        let storePic: String = stepSecondeItem.indoorImage?.path ?? ""  //反面照
        
        //获取第三步资料
        let stepThreeItem = ApplyModel.shareApplyModel.applySelfModel.stepThree
        
        let comaccnum: String = stepThreeItem.openBankAccount ?? "" //对私银行账号
        let opnbank: String = stepThreeItem.openBank ?? ""//开户行
        let ponaccname: String = stepThreeItem.branchnName ?? ""//支行名称
        let accountName: String = stepThreeItem.openbankName ?? ""//私有银行开户行名
        let cardphone: String = stepThreeItem.leftPhone ?? ""//预留手机号
        
        
        let bankProvince: String = stepThreeItem.bankProvince ?? ""//省
        let bankCity: String = stepThreeItem.bankCity ?? ""//市
        let bankArea: String = stepThreeItem.bankCounty ?? ""//县
        
        let openlicense: String = stepThreeItem.permitCard?.path ?? ""  //反面照
        
        
        let parameters:[String:Any] = [
            "cardtype":cardtype,
            "name":name,
            "phone":phone,
            "registerPhone":registerPhone,
            "idcard":idCard,
            "validterm":validity,
            "idcardone":idcardone,
            "idcardtwo":idcardtwo,
            
            "entabb":entabb,
            "entname":entname,
            "busregnum":busregnum,
            "enterpraiseLicenseTerm":enterpraiseLicenseTerm,
            "province":province,
            "city":city,
            "area":area,
            "details":details,
            "industryid":industryid,
            "busregimg":busregimg,
            "gatepic":gatepic,
            "checkStandPic":checkStandPic,
            "storePic":storePic,
            
            "comaccnum":comaccnum,
            "opnbank":opnbank,
            "ponaccname":ponaccname,
            "accountName":accountName,
            "cardphone":cardphone,
            "bankProvince":bankProvince,
            "bankCity":bankCity,
            "bankArea":bankArea,
            "openlicense":openlicense
        ]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.insertMerchant(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                ApplyModelTool.removeModel()
                SZHUD("上传成功", type: .info, callBack: nil)
                self.navigationController?.popToRootViewController(animated: true)
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
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(20)
        }else if indexPath.row == 1 {
            return fit(543)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(497)
        }else{
            return fit(264)
        }
    }
    
}
extension XOpenAccountController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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

extension  XOpenAccountController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传图片中", type:.loading, callBack: nil)
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    self.permitImagePath = frontUrl + obk
                    self.stepThreeModel?.permitCard = ApplyImage(image: image, path: self.permitImagePath)
                    self.imgCell.permitCard.setImage(image, for: .normal)
                    
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}




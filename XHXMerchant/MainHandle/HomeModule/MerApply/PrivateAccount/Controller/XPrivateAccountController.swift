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
    
    var temp :String = "1"
    
    fileprivate var bankProvince:String = ""
    fileprivate var bankCity:String = ""
    fileprivate var bankCounty:String = ""
    
    fileprivate var cardImagePath:String = ""
    fileprivate var backImagePath:String = ""
    var fullname:String = ""

    
    fileprivate let addressPiker = AddressPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))

    
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
        CNLog(self.bankProvince +  self.bankCity + self.bankCounty)

        self.stepThreeModel?.privateBankAccount = fieldCell.privateBankAccountField.text
        self.stepThreeModel?.privateBank = fieldCell.privateBankField.text
        self.stepThreeModel?.privateBankAddress = fieldCell.privateBankAddressField.text
        self.stepThreeModel?.branchName = fieldCell.branchNameField.text
        self.stepThreeModel?.privatebankName = fieldCell.privatebankNameField.text
        self.stepThreeModel?.leftMobile = fieldCell.leftMobileField.text
       

        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
        
    }
    
    func sendSMS(){
        if fieldCell.leftMobileField.text! == ""{
             UIAlertView(title: "温馨提示", message: "请填写银行预留手机号码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        SNRequestBool(requestType: API.sendSMS(mobile:fieldCell.leftMobileField.text!,vtype:"4")).subscribe(onNext: {[unowned self] (result) in
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

        if threeStep.frontCard?.image == nil {
            imgCell.bankCard.setImage(UIImage(named:"bank_card"), for: .normal)
        }else{
            imgCell.bankCard.setImage(threeStep.frontCard?.image, for: UIControlState.normal)
        }
       
        if threeStep.backCard?.image == nil {
            imgCell.bankCardBack.setImage(UIImage(named:"bank_card"), for: .normal)
        }else{
            imgCell.bankCardBack.setImage(threeStep.backCard?.image, for: UIControlState.normal)
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
            fieldCell.timeButton.clickBtnEvent = {[unowned self] in
                self.sendSMS()
            }
 
            fieldCell.privateBankAddressField.inputView = addressPiker
            addressPiker.selectValue = {[unowned self] (string,province,city,county) in
                self.fieldCell.privateBankAddressField.text = string
                self.bankProvince = province
                self.bankCity = city
                self.bankCounty = county
                
                self.stepThreeModel?.bankProvince = self.bankProvince
                self.stepThreeModel?.bankCity = self.bankCity
                self.stepThreeModel?.bankCounty = self.bankCounty

                ApplyModelTool.save(model: ApplyModel.shareApplyModel)
                
            }
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XPrivateAccountImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.imgCell = cell
            cell.imgTap.subscribe(onNext: {[unowned self] (btn,fullname) in
                self.protocolObject = btn
                self.fullname = fullname
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
                self.verifyValue()
            }
            return cell
        }
    }
    
    func verifyValue(){
        if fieldCell.privateBankAccount.text == ""{
            UIAlertView(title: "提示", message: "请输入对私银行账号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.privateBankField.text == ""{
            UIAlertView(title: "提示", message: "请输入开户行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.privateBankAddressField.text == ""{
            UIAlertView(title: "提示", message: "请输入开户行所在地", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.branchNameField.text == ""{
            UIAlertView(title: "提示", message: "请输入支行名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.privatebankNameField.text == ""{
            UIAlertView(title: "提示", message: "请输入银行开户名", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.leftMobileField.text == ""{
            UIAlertView(title: "提示", message: "请输入预留手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if fieldCell.codeLableField.text == ""{
            UIAlertView(title: "提示", message: "请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepThreeModel?.frontCard == nil {
            UIAlertView(title: "提示", message: "请上传银行卡正面照", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if stepThreeModel?.backCard == nil {
            UIAlertView(title: "提示", message: "请上传银行卡反面照", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        //1:企业 2:个人
        if XKeyChain.get(isConpany) == "1"{
//            let vc = XOpenAccountController()
//            vc.verifyCode = fieldCell.codeLableField.text!
//            self.navigationController?.pushViewController(vc, animated: true)
            uploadConpanyData()
        }else{
            uploadPersonData()
        }
        
    }
    func uploadConpanyData(){
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
        let idcardThird: String = stepOneItem.handImage?.path ?? ""  //反面照
        let iDterm: String = stepOneItem.term ?? "1" //省份证有效期
        let email: String = stepOneItem.email ?? "" //邮箱地址
        
        //获取第二步资料
        let stepSecondeItem = ApplyModel.shareApplyModel.applySelfModel.stepTwo
        
        let entabb: String = stepSecondeItem.merShortName ?? ""  //企业简称
        let entname: String = stepSecondeItem.licenseName ?? ""  //企业名称
        let busregnum: String = stepSecondeItem.codeNum ?? ""  //统一社会信用代码
        let enterpraiseLicenseTerm: String = stepSecondeItem.licenseTerm ?? "" // 营业执照有效期
        let details: String = stepSecondeItem.detailAddress ?? ""    // 详细地址
        let industryid: String = stepSecondeItem.industryID ?? ""  // 商家类型
        let province: String = stepSecondeItem.province ?? ""  //省
        let city: String = stepSecondeItem.city ?? ""          //市
        let area: String = stepSecondeItem.county ?? ""        //区
        let licenseTerm: String = stepSecondeItem.term ?? "1"        //有效期
        
        
        let busregimg: String = stepSecondeItem.LicenseImage?.path ?? ""  //反面照
        let gatepic: String = stepSecondeItem.doorImage?.path ?? ""  //反面照
        let checkStandPic: String = stepSecondeItem.checkstand?.path ?? ""  //反面照
        let storePic: String = stepSecondeItem.indoorImage?.path ?? ""  //反面照
        let storePic2: String = stepSecondeItem.indoorImage1?.path ?? ""  //反面照
        
        //获取第三步资料
        let stepThreeItem = ApplyModel.shareApplyModel.applySelfModel.stepThree
        
        
        /*----------------------------对私----------------------------------------------*/
        
        let priaccount: String = stepThreeItem.privateBankAccount ?? "" //对私银行账号
        let opnbank: String = stepThreeItem.privateBank ?? ""//开户行
        let ponaccname: String = stepThreeItem.branchName ?? ""//支行名称
        let accountName: String = stepThreeItem.privatebankName ?? ""//私有银行开户行名
        let cardphone: String = stepThreeItem.leftMobile ?? ""//预留手机号
        let bankProvince: String = stepThreeItem.bankProvince ?? ""//预留手机号
        let bankCity: String = stepThreeItem.bankCity ?? ""//预留手机号
        let bankArea: String = stepThreeItem.bankCounty ?? ""//预留手机号
        
        let balancecardone: String = stepThreeItem.frontCard?.path ?? ""  //正面照
        let balancecardtwo: String = stepThreeItem.backCard?.path ?? ""  //反面照
        
        /*----------------------------对公----------------------------------------------*/
        
        let comaccnum: String = stepThreeItem.openBankAccount ?? "" //对公银行账号
        let publicOpnbank: String = stepThreeItem.openBank ?? ""//开户行
        let publicPonaccname: String = stepThreeItem.branchnName ?? ""//支行名称
        let publicAccountName: String = stepThreeItem.openbankName ?? ""//对公银行开户行名
        let publicCardphone: String = stepThreeItem.leftPhone ?? ""//预留手机号
        
        
        let publicBankProvince: String = stepThreeItem.openBankProvince ?? ""//省
        let publicBankCity: String = stepThreeItem.openBankCity ?? ""//市
        let publicBankArea: String = stepThreeItem.openBankCounty ?? ""//县
        
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
            "idcardThird":idcardThird,
            "term":iDterm,
            "email":email,
            
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
            "storePic2":storePic2,
            "licenseTerm":licenseTerm,
            
            
            "priaccount":priaccount,
            "opnbank":opnbank,
            "ponaccname":ponaccname,
            "accountName":accountName,
            "cardphone":cardphone,
            "balancecardone":balancecardone,
            "bankProvince":bankProvince,
            "bankCity":bankCity,
            "bankArea":bankArea,
            "verifycode":fieldCell.codeLableField.text!,
            "balancecardtwo":balancecardtwo,
            
            
            "comaccnum":comaccnum,
            "publicOpnbank":publicOpnbank,
            "publicPonaccname":publicPonaccname,
            "publicAccountName":publicAccountName,
            "publicCardphone":publicCardphone,
            "publicBankProvince":publicBankProvince,
            "publicBankCity":publicBankCity,
            "publicBankArea":publicBankArea,
            "openlicense":openlicense
        ]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.merchantAddPublic(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
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
    
    func uploadPersonData(){
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
        let idcardThird: String = stepOneItem.handImage?.path ?? ""  //反面照
        let iDterm: String = stepOneItem.term ?? "1" //省份证有效期
        let email: String = stepOneItem.email ?? "" //邮箱号码


        
        //获取第二步资料
        let stepSecondeItem = ApplyModel.shareApplyModel.applySelfModel.stepTwo
        
        let entabb: String = stepSecondeItem.merShortName ?? ""  //企业简称
        let entname: String = stepSecondeItem.licenseName ?? ""  //企业名称
        let busregnum: String = stepSecondeItem.codeNum ?? ""  //统一社会信用代码
        let enterpraiseLicenseTerm: String = stepSecondeItem.licenseTerm ?? "" // 营业执照有效期
        let details: String = stepSecondeItem.detailAddress ?? ""    // 详细地址
        let industryid: String = stepSecondeItem.industryID ?? ""  // 商家类型
        let province: String = stepSecondeItem.province ?? ""  //省
        let city: String = stepSecondeItem.city ?? ""          //市
        let area: String = stepSecondeItem.county ?? ""        //区
        let licenseTerm: String = stepSecondeItem.term ?? "1"        //有效期

        
        let busregimg: String = stepSecondeItem.LicenseImage?.path ?? ""  //反面照
        let gatepic: String = stepSecondeItem.doorImage?.path ?? ""  //反面照
        let checkStandPic: String = stepSecondeItem.checkstand?.path ?? ""  //反面照
        let storePic: String = stepSecondeItem.indoorImage?.path ?? ""  //反面照
        let storePic2: String = stepSecondeItem.indoorImage1?.path ?? ""  //反面照

        //获取第三步资料
        let stepThreeItem = ApplyModel.shareApplyModel.applySelfModel.stepThree
        
        let priaccount: String = stepThreeItem.privateBankAccount ?? "" //对私银行账号
        let opnbank: String = stepThreeItem.privateBank ?? ""//开户行
        let ponaccname: String = stepThreeItem.branchName ?? ""//支行名称
        let accountName: String = stepThreeItem.privatebankName ?? ""//私有银行开户行名
        let cardphone: String = stepThreeItem.leftMobile ?? ""//预留手机号
        let bankProvince: String = stepThreeItem.bankProvince ?? ""//预留手机号
        let bankCity: String = stepThreeItem.bankCity ?? ""//预留手机号
        let bankArea: String = stepThreeItem.bankCounty ?? ""//预留手机号

        let balancecardone: String = stepThreeItem.frontCard?.path ?? ""  //正面照
        let balancecardtwo: String = stepThreeItem.backCard?.path ?? ""  //反面照

        
        let parameters:[String:Any] = [
            "cardtype":cardtype,
            "name":name,
            "phone":phone,
            "registerPhone":registerPhone,
            "idcard":idCard,
            "validterm":validity,
            "idcardone":idcardone,
            "idcardtwo":idcardtwo,
            "idcardThird":idcardThird,
            "term":iDterm,
            "email":email,
            
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
            "storePic2":storePic2,
            "licenseTerm":licenseTerm,

            "priaccount":priaccount,
            "opnbank":opnbank,
            "ponaccname":ponaccname,
            "accountName":accountName,
            "cardphone":cardphone,
            "balancecardone":balancecardone,
            "bankProvince":bankProvince,
            "bankCity":bankCity,
            "bankArea":bankArea,
            "verifycode":fieldCell.codeLableField.text!,
            "balancecardtwo":balancecardtwo

        ]
        CNLog(parameters)

        SNRequestBool(requestType: API.insertMerchant(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                ApplyModelTool.removeModel()
                UIAlertView(title: "提示", message: "上传成功", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                XKeyChain.set("0", key: "three")
                self.navigationController?.popToRootViewController(animated: true)
            case .fail(let code,let res):
                SZHUD(res ?? "上传失败", type: .error, callBack: nil)
                XKeyChain.set("1", key: "three")
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
            return fit(713)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(869)
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
//        cropVC.customAspectRatio = CGSize(width:fit(483),height:fit(260))
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
                    if self.fullname == "1"{
                        self.cardImagePath = frontUrl + obk
                        self.stepThreeModel?.frontCard = ApplyImage(image: image, path: self.cardImagePath)
                        self.imgCell.bankCard.setImage(image, for: .normal)
                    }else{
                        self.backImagePath = frontUrl + obk
                        self.stepThreeModel?.backCard = ApplyImage(image: image, path: self.backImagePath)
                        self.imgCell.bankCardBack.setImage(image, for: .normal)
                    }
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}




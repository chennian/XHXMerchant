//
//  XUpdateBankController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/11.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import TZImagePickerController
class XUploadBankController: SNBaseViewController {
    
//    var phone :String = ""        //手机号码
//    var cardHolder :String = ""   //磁卡人
    var cardImg :String = ""      //银行卡照片
    var bankName :String = ""      //银行
    var bankId :String = ""      //银行id

    var model : BankCardModel?
    var temp:String = ""

    fileprivate var fieldCell:XUpdateBankHeaderCell = XUpdateBankHeaderCell()
    fileprivate var imgCell:XUploadFrontBankCell = XUploadFrontBankCell()
    fileprivate let bankPiker = bankCardPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))

    var protocolObject : AliOssTransferProtocol?

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XUpdateBankHeaderCell.self)
        $0.register(XUploadFrontBankCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }

    fileprivate func setupUI() {
        self.title = "添加银行卡"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension XUploadBankController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell:XUpdateBankHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.fieldCell = cell

            if let cellModel = self.model{
                cell.phoneLableField.text = cellModel.phone
                cell.cardholderField.text = cellModel.real_name
                cell.IDCardField.text = cellModel.real_card
                cell.bankNumField.text = cellModel.bank_num
                cell.cardBankField.text = cellModel.bank_name
                cell.cardBranchBankField.text = cellModel.subbranch
            }
            
            cell.cardBankField.inputView = self.bankPiker
            bankPiker.selectValue = {[unowned self] (name,id) in
                self.fieldCell.cardBankField.text = name
                self.bankName = name
                self.bankId = id
            }
            cell.timeButton.clickBtnEvent = { [unowned self] () in
                
                if self.fieldCell.phoneLableField.text! == "" {
                     UIAlertView(title: "温馨提示", message:"请填写手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                    return
                }
                
                SNRequestBool(requestType: API.sendSMS(mobile:self.fieldCell.phoneLableField.text!,vtype:"5")).subscribe(onNext: {[unowned self] (result) in
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
            return cell
        }else{
            let cell:XUploadFrontBankCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.imgCell = cell
            if let cellModel = self.model{
                cell.bankCardImg.kf.setImage(with: URL(string:cellModel.bank_logo), for: .normal)
            }
            cell.clickEvent = { [unowned self] in
                if self.temp == "1"{
                  self.updateData()
                }else{
                    self.upLoadData()
                }
            }
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
        }
    }
    func updateData(){
        if  fieldCell.phoneLableField.text! == ""{
            UIAlertView(title: "提示", message: "请输入手机号码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.cardholderField.text! == ""{
            UIAlertView(title: "提示", message: "请输入持卡人", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.IDCardField.text! == ""{
            UIAlertView(title: "提示", message: "请输入身份证号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.bankNumField.text! == ""{
            UIAlertView(title: "提示", message: "请输入银行卡号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.cardBankField.text! == ""{
            UIAlertView(title: "提示", message: "请输入开卡银行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.cardBranchBankField.text! == ""{
            UIAlertView(title: "提示", message: "请输入开卡支行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.codeLableField.text! == ""{
            UIAlertView(title: "提示", message: "请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
//
//        if  self.cardImg  == ""{
//            UIAlertView(title: "提示", message: "请上传银行卡正面照", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
//            return
//        }
        
        var tempBankId:String = ""
        
        if self.bankId == ""{
            tempBankId = (self.model?.bank_id)!
        }else{
            tempBankId = self.bankId
        }
        
        var tempCardImg = ""
        if cardImg == "" {
            tempCardImg = (self.model?.bank_logo)!
        }else{
            tempCardImg = self.cardImg
        }
        
        let parameters:[String:Any] = [
            "phone":self.fieldCell.phoneLableField.text!,
            "code":self.fieldCell.codeLableField.text!,
            "real_name":self.fieldCell.cardholderField.text!,
            "real_card":self.fieldCell.IDCardField.text!,
            "bank_num":fieldCell.bankNumField.text!,
            "bank_id":tempBankId,
            "bank_name":self.fieldCell.cardBankField.text!,
            "subbranch":fieldCell.cardBranchBankField.text!,
            "bank_logo":tempCardImg
        ]
        
        CNLog(parameters)
        
        SNRequestBool(requestType: API.updateBank(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                SZHUD("更新成功", type: .success, callBack: nil)
                self.navigationController?.popToRootViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
    }
    
    func upLoadData(){
        if  fieldCell.phoneLableField.text! == ""{
            UIAlertView(title: "提示", message: "请输入手机号码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.cardholderField.text! == ""{
            UIAlertView(title: "提示", message: "请输入持卡人", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.bankNumField.text! == ""{
             UIAlertView(title: "提示", message: "请输入银行卡号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.cardBankField.text! == ""{
            UIAlertView(title: "提示", message: "请输入开卡银行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.cardBranchBankField.text! == ""{
            UIAlertView(title: "提示", message: "请输入开卡支行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  fieldCell.codeLableField.text! == ""{
            UIAlertView(title: "提示", message: "请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if  self.cardImg  == ""{
            UIAlertView(title: "提示", message: "请上传银行卡正面照", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let parameters:[String:Any] = [
            "phone":self.fieldCell.phoneLableField.text!,
            "verifycode":self.fieldCell.codeLableField.text!,
            "real_name":self.fieldCell.cardholderField.text!,
            "real_card":self.fieldCell.IDCardField.text!,
            "bank_num":fieldCell.bankNumField.text!,
            "bank_id":self.bankId,
            "bank_name":self.fieldCell.cardBankField.text!,
            "subbranch":fieldCell.cardBranchBankField.text!,
            "bank_logo":self.cardImg
        ]
        
        SNRequestBool(requestType: API.addBankcard(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return fit(713)
        }else{
            return fit(716)
        }
    }
    
}
extension XUploadBankController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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

extension  XUploadBankController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传图片中", type:.loading, callBack: nil)
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    self.cardImg = frontUrl + obk
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}




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
    
//    var addressPiker = UIPickerView().then{
//        $0.backgroundColor = Color(0xffffff)
//        $0.showsSelectionIndicator = true;
//
//    }
//
//    var toolBar = UIToolbar().then{
//        $0.barTintColor = .red
//        $0.isTranslucent = true
//        $0.sizeToFit()
//    }
    
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
//        addressPiker.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.width.equalTo(ScreenW)
//            make.height.snEqualTo(400)
//        }
//
//        addressPiker.delegate = self
//        addressPiker.dataSource = self
        
//        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(selected))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        fieldCell.areaField.inputView = addressPiker
//        fieldCell.areaField.inputAccessoryView = toolBar


    }
    
//   @objc fileprivate func selected(){
//
//    }
//   @objc fileprivate func cancel(){
//    }
//    fileprivate func loadAddressData(){
//        let JsonPath = Bundle.main.path(forResource: "province_data", ofType: "json")
//        let url = URL(fileURLWithPath: JsonPath!)
//        do {
//            let data = try Data(contentsOf: url)
//            jsonArr = JSON(data: data)
//
//            for (_,subJson):(String,JSON) in jsonArr {
//                provinceArray.append(subJson["name"].string!)
//
//            }
//            for (_,subJson):(String,JSON) in jsonArr[0]["sub"] {
//                cityArray.append(subJson["name"].string!)
//
//            }
//            for (_,subJson):(String,JSON) in jsonArr[0]["sub"][0]["sub"] {
//                countyArray.append(subJson["name"].string!)
//            }
//
//        } catch let error as Error? {
//            print("读取本地数据出现错误!",error as Any)
//        }
//    }
    
    func saveModel(){
        
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
//        loadAddressData()

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
            return cell
        }else if indexPath.row == 1{
            let cell:XMerLicenseFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            fieldCell = cell
            fieldCell.areaField.inputView = addressPiker
            addressPiker.selectValue = {[unowned self] (string) in
                self.fieldCell.areaField.text = string
            }
            
            fieldCell.industryTypeField.inputView = industyPiker
            industyPiker.selectValue = {[unowned self] (string) in
                self.fieldCell.industryTypeField.text = string
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
                self.navigationController?.pushViewController(XPrivateAccountController(), animated: true)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(20)
        }else if indexPath.row == 1 {
            return fit(636)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(1649)
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
                    }else{
                        self.indoorImagePath = frontUrl + obk
                        self.stepTwoModel?.indoorImage = ApplyImage(image: image, path: self.indoorImagePath)
                        self.imgCell.indoorImage.setImage(image, for: .normal)
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
//extension XMerLicenseController:UIPickerViewDelegate,UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3
//    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
//                    forComponent component: Int, reusing view: UIView?) -> UIView {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = Font(26)
//        label.textColor = Color(0x313131)
//        label.text = pickerView.delegate?.pickerView!(pickerView, titleForRow: row, forComponent: component)
//        label.frame = CGRect(x: 0, y: 0, width: fit(240), height: fit(30))
//        return label
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        CNLog(provinceArray)
//        if (component == 0) {
//            return provinceArray.count;
//        }
//        if (component==1) {
//            return  cityArray.count;
//        }
//        if (component==2) {
//            return countyArray.count;
//        }
//        return 0;
//    }
//
//    //设置列宽
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if component == 0 {
//            return fit(240)
//        }else if component == 1{
//            return fit(240)
//        }else{
//            return fit(240)
//        }
//    }
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int)
//        -> CGFloat {
//            return fit(80)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0 {
//            return provinceArray[row];
//        }
//        if component == 1 {
//            return cityArray[row];
//        }
//        if component == 2 {
//            return countyArray[row];
//        }
//        return nil;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if component == 0 {
//            cityArray.removeAll()
//            countyArray.removeAll()
//            for (_,subJson):(String,JSON) in jsonArr[row]["sub"] {
//                cityArray.append(subJson["name"].string!)
//            }
//            pickerView.reloadComponent(1)
//            pickerView.selectRow(0, inComponent: 1, animated: false)
//
//            for (_,subJson):(String,JSON) in jsonArr[row]["sub"][0]["sub"] {
//                countyArray.append(subJson["name"].string!)
//            }
//            pickerView.reloadComponent(2)
//            pickerView.selectRow(0, inComponent: 2, animated: false)
//
//            self.counrentRow = row
//
//            provinceString = provinceArray[row]
//            cityString = cityArray[0]
//            countyString = countyArray[0]
//        }
//        if component == 1 {
//            countyArray.removeAll()
//            for (_,subJson):(String,JSON) in jsonArr[counrentRow]["sub"][row]["sub"] {
//                countyArray.append(subJson["name"].string!)
//            }
//            pickerView.reloadComponent(2)
//            pickerView.selectRow(0, inComponent: 2, animated: false)
//            cityString = cityArray[row]
//            countyString = countyArray[0]
//        }
//        if component == 2 {
//           countyString = countyArray[row]
//        }
//        CNLog(provinceString + cityString + countyString)
//    }
//}



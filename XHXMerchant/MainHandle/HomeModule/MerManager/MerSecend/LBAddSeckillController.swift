//
//  LBAddStickController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import TOCropViewController
class LBAddSeckillController: SNBaseViewController {
    
    fileprivate var fieldCell:LBAddSeckillFieldCell = LBAddSeckillFieldCell()
    fileprivate var descCell:LBAddSeckillDescriptionCell = LBAddSeckillDescriptionCell()

    fileprivate var name:String = ""
    fileprivate var price:String = ""
    fileprivate var endTime:String = ""
    fileprivate var termTime:String = ""
    fileprivate var cardNum:String = ""
    fileprivate var mainImg:String = ""
    fileprivate var detailImg:String = ""
    fileprivate var mercId:String = ""    //id
    fileprivate var desc:String = ""
    
    var shopid :String = ""  
    fileprivate var detailImgArray:[String] = []
    var model : XSeckillListModel?
    var temp:String = ""

    fileprivate var detailImg1:String = ""
    fileprivate var detailImg2:String = ""
    fileprivate var detailImg3:String = ""
    
    fileprivate lazy var datePicker:UIDatePicker = UIDatePicker()
    
    fileprivate lazy var seckillDescriptionCell = LBAddSeckillDescriptionCell()

    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    typealias PickedImageHandle = (UIImage) -> ()
    fileprivate var imagePickerFinishHandle: PickedImageHandle?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(LBAddSeckillFieldCell.self)
        $0.register(LBAddSeckillActivityCell.self)
        $0.register(LBAddSeckillDetailImgCell.self)
        $0.register(LBAddSeckillDescriptionCell.self)
        $0.register(LBSubmitButtonCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    
    override func setupView() {
        setupUI()

    }
    
    func setUpPikerView(){
        datePicker.frame = CGRect(x:0, y:0, width:ScreenW, height:216)
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
//        self.view.addSubview(datePicker)
        tableView.addSubview(datePicker)
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.white, forKey: "textColor")
//        datePicker.backgroundColor = UIColor.red
    }
    
    //日期选择器响应方法
    @objc func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        print(formatter.string(from: datePicker.date))
    }
    
    func setupUI() {
//        setUpPikerView()

        self.title = "新建秒秒"
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
    
    func showMessage(title: String, message: String) {
            UIAlertView(title: title,
                        message:message,
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
    }
    //上传数据
    @objc fileprivate func uploadData(){
        self.name = fieldCell.titleTextField.text!
        self.price = fieldCell.priceTextField.text!
        self.cardNum = fieldCell.numTextField.text!
        self.endTime = fieldCell.countTextField.text!
        self.termTime = fieldCell.termTextField.text!
        self.desc = descCell.descriptionText.text!
        CNLog(detailImgArray)
        detailImg = self.detailImgArray.joined(separator: "|")
        print(detailImg)
        
        guard !name.isEmpty else {
            showMessage(title: "提示", message: "请输入标题")
            return
        }

        guard !price.isEmpty else {
            showMessage(title: "提示", message: "请输入价格")
            return
        }

        guard !endTime.isEmpty else {
            showMessage(title: "提示", message: "请输入倒计时")
            return
        }
        guard !termTime.isEmpty else {
            showMessage(title: "提示", message: "请输入倒计时")
            return
        }
        print(cardNum)
        guard !cardNum.isEmpty else {
            showMessage(title: "提示", message: "请输入商品数量")
            return
        }
        
        guard !mainImg.isEmpty else {
            showMessage(title: "提示", message: "请上传展示图片")
            return
        }
        guard detailImgArray.count == 3 else {
            showMessage(title: "提示", message: "请上传详情展示图")
            return
        }
        guard !desc.isEmpty else {
            showMessage(title: "提示", message: "请输入卡卷描述")
            return
        }
        
        print(detailImgArray)
        
        let paramert:[String:String] = ["name":name,
                                        "price":price,
                                        "endTime":endTime,
                                        "terminaltime":termTime,
                                        "numbers":cardNum,
                                        "mainImg":mainImg,
                                        "detailImg":detailImg,
                                        "description":desc,
                                        "shopId":shopid]
        //上传数据

        SZHUD("正在上传中...", type: .loading, callBack: nil)
      
        SNRequestBool(requestType: API.addSecond(paremeter:paramert)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                UIAlertView(title: "温馨提示", message: msg, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
                self.navigationController?.popViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()

            }
        }).disposed(by: disposeBag)
        
        }
    
    //编辑
    
    @objc fileprivate func editData(){
        self.name = fieldCell.titleTextField.text!
        self.price = fieldCell.priceTextField.text!
        self.cardNum = fieldCell.numTextField.text!
        self.endTime = fieldCell.countTextField.text!
        self.termTime = fieldCell.termTextField.text!
        self.desc = descCell.descriptionText.text!
        CNLog(detailImgArray)
        detailImg = self.detailImgArray.joined(separator: "|")
        print(detailImg)
        
        guard !name.isEmpty else {
            showMessage(title: "提示", message: "请输入标题")
            return
        }
        
        guard !price.isEmpty else {
            showMessage(title: "提示", message: "请输入价格")
            return
        }
        
        guard !endTime.isEmpty else {
            showMessage(title: "提示", message: "请输入倒计时")
            return
        }
        guard !termTime.isEmpty else {
            showMessage(title: "提示", message: "请输入倒计时")
            return
        }
        print(cardNum)
        guard !cardNum.isEmpty else {
            showMessage(title: "提示", message: "请输入商品数量")
            return
        }
        
        var tempMainImg:String = ""
        if mainImg.isEmpty{
            tempMainImg = (self.model?.mainImg)!
        }else{
            tempMainImg = mainImg
        }
        
        var tempDetailImg:String = ""
        if   detailImgArray.isEmpty{
            tempDetailImg = (self.model?.detailImg)!
        }else{
            tempDetailImg = detailImg
        }
        
    
//        guard !mainImg.isEmpty else {
//            showMessage(title: "提示", message: "请上传展示图片")
//            return
//        }
//        guard detailImgArray.count == 3 else {
//            showMessage(title: "提示", message: "请上传详情展示图")
//            return
//        }
        guard !desc.isEmpty else {
            showMessage(title: "提示", message: "请输入卡卷描述")
            return
        }
        
        print(detailImgArray)
        
        let paramert:[String:String] = ["id":(self.model?.id)!,
                                        "name":name,
                                        "price":price,
                                        "endTime":endTime,
                                        "terminaltime":termTime,
                                        "cardNum":cardNum,
                                        "mainImg":tempMainImg,
                                        "detailImg":tempDetailImg,
                                        "description":desc,
                                        "shopId":(self.model?.shopId)!]
        //上传数据
        CNLog(paramert)
        SZHUD("正在上传中...", type: .loading, callBack: nil)
        
        SNRequestBool(requestType: API.editShopKill(paremeter:paramert)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                UIAlertView(title: "温馨提示", message: msg, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
                self.navigationController?.popViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                SZHUDDismiss()
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

extension LBAddSeckillController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //case

        
        if indexPath.row == 0{
            let cell : LBAddSeckillFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.fieldCell = cell
            if  let  model =  self.model {
                cell.titleTextField.text = model.name
                cell.priceTextField.text = model.price
                cell.countTextField.text = model.endTime
                cell.termTextField.text = model.terminaltime
                cell.numTextField.text = model.cardNum
            }
            return cell
            
        }else if indexPath.row == 1{
            let cell : XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 2{
            let cell : LBAddSeckillActivityCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let model = self.model{
                 cell.activityImge.kf.setImage(with:URL(string:model.mainImg), for: .normal)
            }
           
            cell.imgTap1.subscribe(onNext: {[unowned self] (btn,fullname) in
                
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
            
        }else if indexPath.row == 3{
            let cell : XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 4{
            let cell : LBAddSeckillDetailImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            if let model = self.model{
                let detailImgArray = model.detailImg.components(separatedBy:"|")
                if detailImgArray.count == 3{
                    cell.showImge1.kf.setImage(with: URL(string:detailImgArray[0]), for: .normal)
                    cell.showImge2.kf.setImage(with: URL(string:detailImgArray[1]), for: .normal)
                    cell.showImge3.kf.setImage(with: URL(string:detailImgArray[2]), for: .normal)
                }else if detailImgArray.count == 2{
                    cell.showImge1.kf.setImage(with: URL(string:detailImgArray[0]), for: .normal)
                    cell.showImge2.kf.setImage(with: URL(string:detailImgArray[1]), for: .normal)
                    cell.showImge3.setImage(UIImage(named: "new_addition"), for: .normal)
                }else{
                    cell.showImge1.kf.setImage(with: URL(string:detailImgArray[0]), for: .normal)
                    cell.showImge2.setImage(UIImage(named: "new_addition"), for: .normal)
                    cell.showImge3.setImage(UIImage(named: "new_addition"), for: .normal)
                }
                
            }
            
            cell.imgTap.subscribe(onNext: {[unowned self] (btn,fullname) in
                
                self.fullName = fullname
                self.protocolObject = btn
                let alertView = DDZCamerationController()
                let picker = DDZImagePickerVC()
                picker.delegate = self
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                        picker.sourceType = .camera
                        
//                        delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                        self.present(picker, animated: true, completion: nil)
                    })
                    alertView.addAction(action)
                }
                
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                        picker.sourceType = .savedPhotosAlbum
//                        delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                        self.present(picker, animated: true, completion: nil)
                        
                    })
                    alertView.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
            }).disposed(by: cell.disposeBag)
            return cell
            
        }else if indexPath.row == 5{
            let cell : XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 6{
            let cell :LBAddSeckillDescriptionCell  = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let model = self.model{
                cell.descriptionText.text = model.description
            }
            self.descCell = cell
            return cell
        }else if indexPath.row == 7{
            let cell : XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else {
            let cell : LBSubmitButtonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.contentView.backgroundColor = color_bg_gray_f5
            cell.submitBoutton.setTitle("确定", for: UIControlState.normal)
            if self.temp == "1"{
                cell.submitBoutton.addTarget(self, action: #selector(editData), for: .touchUpInside)

            }else{
                cell.submitBoutton.addTarget(self, action: #selector(uploadData), for: .touchUpInside)

            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //case
        if indexPath.row == 0{
            return fit(455)
        }else if indexPath.row == 1{
            return fit(16)
            
        }else if indexPath.row == 2{
            return fit(300)
            
        }else if indexPath.row == 3{
            return fit(16)
            
        }else if indexPath.row == 4{
            return fit(305)
            
        }else if indexPath.row == 5{
            return fit(16)
            
        }else if indexPath.row == 6{
            return fit(305)
            
        }else if indexPath.row == 7{
            return fit(16)
        }else{
            return fit(120)
            
        }
        }
        
    }

extension LBAddSeckillController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        if self.fullName == "img1" || self.fullName == "img2" || self.fullName == "img3"  {
            cropVC.customAspectRatio = CGSize(width:1,height:1)
            
        }else{
            cropVC.customAspectRatio = CGSize(width:270,height:158)
        }

        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension LBAddSeckillController : TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    let path = frontUrl + obk
                    if self.fullName == "img5"{
                        self.mainImg = path
                    }else{
                        self.detailImgArray.append(path)
                    }
                }
            })
        }
    }
}




//
//  XMerDataController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import TZImagePickerController
class XMerDataController: SNBaseViewController {
    var endCell:XMerDataEndCell = XMerDataEndCell()
    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    var activityImgPath : String = ""
    var logoImgPath : String = ""
    var detailImgs : [String] = []
    var detailImgPath:String = ""
    var shortName:String = ""
    var shopId : String = ""
    var model:[XMerListModel] = []
    
    
    let searcher = BMKGeoCodeSearch()
    let searcherOption = BMKGeoCodeSearchOption()
    var location:CLLocationCoordinate2D?


    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMerActiveImgCell.self)
        $0.register(XMerLogoImgCell.self)
        $0.register(XMerDetailImgsCell.self)
        $0.register(XMerDataEndCell.self)
        $0.register(XButtonCell.self)

        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
 
    
    //接受通知
    func receiveNotify(){
        let NotifyOne = NSNotification.Name(rawValue:"shopName")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopName(notify:)), name: NotifyOne, object: nil)
        let NotifyTwo = NSNotification.Name(rawValue:"shopPhone")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopPhone(notify:)), name: NotifyTwo, object: nil)
        let NotifyThree = NSNotification.Name(rawValue:"shopCate")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopLable(notify:)), name: NotifyThree, object: nil)
        let NotifyFour = NSNotification.Name(rawValue:"shopLable")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopCate(notify:)), name: NotifyFour, object: nil)
        let NotifyFive = NSNotification.Name(rawValue:"shopAddress")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopAddress(notify:)), name: NotifyFive, object: nil)
    }
    
    fileprivate func setupUI() {
        self.title = "店铺资料"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        receiveNotify()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    @objc func getShopName(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        self.endCell.viewOne.nameLable.text = text
    }
    @objc func getShopPhone(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        self.endCell.viewTwo.nameLable.text = text
    }
    @objc func getShopLable(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        self.endCell.viewThree.nameLable.text = text
    }
    @objc func getShopCate(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        self.endCell.viewFour.nameLable.text = text
    }
    @objc func getShopAddress(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        self.endCell.viewFive.nameLable.text = text
        
        //地理编码
        geoCode(text)
        
    }
    func geoCode(_ address:String){
        searcher.delegate = self
        searcherOption.address = address
        searcherOption.city = XKeyChain.get("CITY")
        let flag: Bool = searcher.geoCode(searcherOption)
        if flag {
            print("geo检索发送成功")
        } else {
            print("geo检索发送失败")
        }
    }

    fileprivate func submit(){
        if !detailImgs.isEmpty {
            self.detailImgPath = detailImgs.joined(separator:"|")
        }
        if self.shopId == "" {
            UIAlertView(title: "温馨提示", message: "店铺ID不存在", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.activityImgPath == "" {
            UIAlertView(title: "温馨提示", message: "请上传活动图片", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.logoImgPath == "" {
            UIAlertView(title: "温馨提示", message: "请上传logo", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.detailImgPath == "" {
            UIAlertView(title: "温馨提示", message: "请上传商家详情图", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.endCell.viewOne.nameLable.text == "" {
            UIAlertView(title: "温馨提示", message: "请填写店铺简称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.endCell.viewTwo.nameLable.text == "" {
            UIAlertView(title: "温馨提示", message: "请填写服务电话", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.endCell.viewThree.nameLable.text == "" {
            UIAlertView(title: "温馨提示", message: "请填写店铺类别", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.endCell.viewFour.nameLable.text == "" {
            UIAlertView(title: "温馨提示", message: "请填写店铺标签", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if self.endCell.viewFive.nameLable.text == "" {
            UIAlertView(title: "温馨提示", message: "请填写店铺地址", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let parameters:[String:Any] = ["shopId":self.shopId,
                                       "category":self.endCell.viewThree.nameLable.text!,
                                       "shopName":self.endCell.viewOne.nameLable.text!,
                                       "banner":activityImgPath,
                                       "logo":logoImgPath,
                                       "detail":self.detailImgPath,
                                       "tab":self.endCell.viewFour.nameLable.text!,
                                       "address":self.endCell.viewFive.nameLable.text!,
                                       "phone":self.endCell.viewTwo.nameLable.text!,
                                       "longitude":"\(String(describing: self.location?.longitude))",
                                       "latitude":"\(String(describing: self.location?.latitude))"]
        
        CNLog(parameters)
        SNRequestBool(requestType: API.submitShopDate(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(let msg):
                SZHUD(msg, type: .success, callBack: nil)
                self.navigationController?.popViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        setupUI()
//        loadShopData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //定位
        XLocationManager.shareUserInfonManager.startUpLocation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        XLocationManager.shareUserInfonManager.stopUpLocation()
        searcher.delegate = nil;
    }
    
    func loadShopData() {
        SNRequest(requestType: API.shopHome(shopId:self.shopId), modelType: [XMerListModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
                self.tableView.reloadData()
            case .fail(let code ,let msg):
                SZHUD(msg ?? "获取数据失败", type:.error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

extension XMerDataController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let cell:XMerActiveImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if !self.model.isEmpty{
                cell.model = self.model[0]
                if self.model[0].banner != ""{
                    self.activityImgPath = self.model[0].banner
                }
                if self.model[0].logo != ""{
                    self.logoImgPath = self.model[0].logo
                }
                if self.model[0].detail != ""{
                    self.detailImgPath = self.model[0].detail
                }
            }
            cell.imgTap.subscribe(onNext: {[unowned self] (btn,fullname) in
                self.protocolObject = btn
                self.fullName = fullname
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
            
            let cell:XMerDataEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.endCell = cell
            if !self.model.isEmpty{
                cell.viewOne.nameLable.text = self.model[0].shopName
                cell.viewTwo.nameLable.text = self.model[0].phone
                cell.viewThree.nameLable.text = self.model[0].category
                cell.viewFour.nameLable.text =  self.model[0].tab
                cell.viewFive.nameLable.text =  self.model[0].address
            }
            
            cell.clickBlock = {[unowned self] (para) in
                if para == "1"{
                    self.navigationController?.pushViewController(XMerShortNameController(), animated: true)
                }else if para == "2"{
                    self.navigationController?.pushViewController(XMerServicePhoneController(), animated: true)
                }else if para == "3"{
                    self.navigationController?.pushViewController(XMerCateController(), animated: true)
                }else if para == "4"{
                    self.navigationController?.pushViewController(XMerLableController(), animated: true)
                }else{
                    self.navigationController?.pushViewController(XMerAddressController(), animated: true)
//                    XLocationManager.shareUserInfonManager.startUpLocation()
//                    cell.viewFive.nameLable.text = XKeyChain.get("ADDRESS")
                }
                
            }
            return cell
        }else if indexPath.row == 4{
            let cell:XButtonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.submitBoutton.setTitle("提交", for: .normal)
            cell.submitBoutton.setTitleColor(Color(0xffffff), for: .normal)
            cell.clickBtnEvent = {[unowned self] (para) in
                self.submit()
            }
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return fit(1256)
        }else if indexPath.row == 3{
            return fit(500)
        }else if indexPath.row == 4{
            return fit(260)
        }else{
            return fit(20)
        }
    }
    
}
extension XMerDataController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        if self.fullName == "1"{
            cropVC.customAspectRatio = CGSize(width:fit(509),height:fit(232))
        }else if self.fullName == "2"{
            cropVC.customAspectRatio = CGSize(width:fit(232),height:fit(232))
        }else{
            cropVC.customAspectRatio = CGSize(width:fit(190),height:fit(190))
        }
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension  XMerDataController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传图片中", type:.loading, callBack: nil)
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    let  imgPath = frontUrl + obk
                    if self.fullName == "1"{
                        self.activityImgPath = imgPath
                    }else if self.fullName == "2"{
                        self.logoImgPath = imgPath
                    }else{
                        self.detailImgs.append(imgPath)
                    }
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}

extension XMerDataController:BMKGeoCodeSearchDelegate{
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
          self.location = result.location
        }else{
            CNLog("未找到结果")
        }
    }
}


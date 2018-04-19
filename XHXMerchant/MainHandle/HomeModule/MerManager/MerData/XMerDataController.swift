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
    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    var activityImgPath : String = ""
    var logoImgPath : String = ""
    var detailImgs : [String] = []
    var detailImgPath:String = ""
    var shortName:String = ""

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
    
    fileprivate func setupUI() {
        self.title = "店铺资料"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    fileprivate func submit(){
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
        
        let parameters:[String:Any] = ["shopId":"",
                                       "category":"",
                                       "shopName":"",
                                       "banner":activityImgPath,
                                       "logo":logoImgPath,
                                       "detail":detailImgs.joined(separator:"|"),
                                       "tab":"",
                                       "address":"",
                                       "phone":""]
        
        SNRequestBool(requestType: API.insertMerchant(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                ApplyModelTool.removeModel()
                SZHUD("上次成功", type: .success, callBack: nil)
                self.navigationController?.popToRootViewController(animated: true)
            case .fail(let res):
                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
}

extension XMerDataController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let cell:XMerActiveImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
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
            let cell:XMerLogoImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
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
        }else if indexPath.row == 5{
            let cell:XMerDetailImgsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
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
        }else if indexPath.row == 7{
            let cell:XMerDataEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickBlock = {[unowned self] (para) in
                if para == "1"{
                    self.navigationController?.pushViewController(XMerShortNameController(), animated: true)
                }
                
            }
            return cell
        }else if indexPath.row == 8{
            let cell:XButtonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
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
            return fit(428)
        }else if indexPath.row == 3{
            return fit(428)
        }else if indexPath.row == 5{
            return fit(360)
        }else if indexPath.row == 7{
            return fit(504)
        }else if indexPath.row == 8{
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




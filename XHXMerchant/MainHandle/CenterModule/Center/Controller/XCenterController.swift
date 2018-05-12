//
//  XCenterController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import TZImagePickerController

class XCenterController: SNBaseViewController {
    fileprivate var topCell:XCenterHeadCell = XCenterHeadCell()
    fileprivate var loginoutCell:XLoginOutCell = XLoginOutCell()
    var protocolObject : AliOssTransferProtocol?
    var imgPath:String = ""
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XCenterHeadCell.self)
        $0.register(XCenterListCell.self)
        $0.register(XLoginOutCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        if XKeyChain.get(PHONE) == ""{
            topCell.name.text = "未登录"
        }else{
            topCell.name.text = XKeyChain.get(PHONE)
        }
        
        CNLog(XKeyChain.get(IsAgent) + XKeyChain.get(OPERATER) + XKeyChain.get(CORPORATION))
        if XKeyChain.get(PHONE) == "" || XKeyChain.get(PHONE).isEmpty{
            loginoutCell.loginOutBtn.setTitle("登录", for: .normal)
            topCell.phone.text = ""
        }else{
            loginoutCell.loginOutBtn.setTitle("退出登录", for: .normal)

            if XKeyChain.get(IsAgent) == "1" {
                if XKeyChain.get(OPERATER) == "1"  {
                    if XKeyChain.get(CORPORATION) == "1" {
                        topCell.phone.text = "服务商    运营商    服务中心"
                    }else{
                        topCell.phone.text = "服务商    运营商"
                    }
                }else{
                    if XKeyChain.get(CORPORATION) == "1"{
                        topCell.phone.text = "服务商    服务中心"
                    }else{
                        topCell.phone.text = "服务商"
                        
                    }
                }
            }else{
                if XKeyChain.get(OPERATER) == "1"  {
                    if XKeyChain.get(CORPORATION) == "1" {
                        topCell.phone.text = "运营商    服务中心"
                    }else{
                        topCell.phone.text = "运营商"
                    }
                }else{
                    if XKeyChain.get(CORPORATION) == "1"{
                        topCell.phone.text = "服务中心"
                    }else{
                        topCell.phone.text = "商家"
                        
                    }
                }
                
            }
            
        }
        
        
        navigationController?.navigationBar.barTintColor = Color(0xff8518)
        
        (navigationController as! SNBaseNaviController).hindShadowImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0xffffff),NSAttributedStringKey.font:Font(36)]
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = Color(0xffffff)
        (navigationController as! SNBaseNaviController).resetShadowImage()
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0x313131),NSAttributedStringKey.font:Font(36)]
    }

    func setupUI() {
     
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension XCenterController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XCenterHeadCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            topCell = cell
            if XKeyChain.get(HEADIMG) != ""{
                topCell.headImg.kf.setImage(with: URL(string:XKeyChain.get(HEADIMG)), for: .normal)
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
            
            if XKeyChain.get(PHONE) == ""{
                cell.name.text = "未登录"
            }else{
                cell.name.text = XKeyChain.get(PHONE)
            }
            
            CNLog(XKeyChain.get(IsAgent) + XKeyChain.get(OPERATER) + XKeyChain.get(CORPORATION))
            if XKeyChain.get(PHONE) == ""{
                cell.phone.text = ""
            }else{
                if XKeyChain.get(IsAgent) == "1" {
                    if XKeyChain.get(OPERATER) == "1"  {
                        if XKeyChain.get(CORPORATION) == "1" {
                            cell.phone.text = "服务商    运营商    服务中心"
                        }else{
                            cell.phone.text = "服务商    运营商"
                        }
                    }else{
                        if XKeyChain.get(CORPORATION) == "1"{
                            cell.phone.text = "服务商    服务中心"
                        }else{
                            cell.phone.text = "服务商"

                        }
                    }
                }else{
                    if XKeyChain.get(OPERATER) == "1"  {
                        if XKeyChain.get(CORPORATION) == "1" {
                            cell.phone.text = "运营商    服务中心"
                        }else{
                            cell.phone.text = "运营商"
                        }
                    }else{
                        if XKeyChain.get(CORPORATION) == "1"{
                            cell.phone.text = "服务中心"
                        }else{
                            cell.phone.text = "商家"
                            
                        }
                    }
                    
                }
            
            }
            
            
            return cell
        }else if indexPath.row == 1 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

            return cell
        }else if indexPath.row == 2 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "银行卡管理"
            cell.img.image = UIImage(named: "my_card")
            cell.accessoryType = .disclosureIndicator
            return cell
        }else if indexPath.row == 3 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "修改登录密码"
            cell.img.image = UIImage(named: "my_password")
            cell.accessoryType = .disclosureIndicator

            return cell
        }
        else if indexPath.row == 4 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "支付密码"
            cell.img.image = UIImage(named: "my_Secondary_Password")
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }else if indexPath.row == 5 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "推送开关"
            cell.img.image = UIImage(named: "my_switch")
            cell.accessoryType = .disclosureIndicator

            return cell
        }else if indexPath.row == 6 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "关于小黑熊商家版"
            cell.img.image = UIImage(named: "mu_regard")
            cell.accessoryType = .disclosureIndicator
            return cell
        }else if indexPath.row == 7{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:XLoginOutCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.loginoutCell = cell
            cell.clickEvent = {[unowned self] in
                
                let NotifMycation = NSNotification.Name(rawValue:"DELETE")
                NotificationCenter.default.post(name: NotifMycation, object:XKeyChain.get(PHONE))
                
                
                
                if XKeyChain.get(ISLOGIN) == "1"{
                    XKeyChain.set("0", key: ISLOGIN)
                    XKeyChain.set("", key: PHONE)
                    XKeyChain.set("", key:IsMer )
                    XKeyChain.set("", key:IsAgent )
                    XKeyChain.set("", key:ROLE )
                    XKeyChain.set("", key:NickName)
                    XKeyChain.set("", key:PARENTPHONE)
                    XKeyChain.set("", key:OPERATER)
                    XKeyChain.set("", key:CORPORATION)
                    XKeyChain.set("", key:isStaff)

                }
                
                self.navigationController?.pushViewController(XLoginController(), animated: true)
                
              

            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(203)
        }else if indexPath.row == 1{
            return fit(20)
        }else if indexPath.row == 8{
            return fit(100)
        }else{
            return fit(90)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
//            SZHUD("正在开发中...", type: .info, callBack: nil)
            navigationController?.pushViewController(XMyBankCardController(), animated: true)
        }
        if indexPath.row == 3 {
            navigationController?.pushViewController(XForgetPwdController(), animated: true)
        }
        if indexPath.row == 4 {
            navigationController?.pushViewController(XForgetPwdController(), animated: true)
        }
        if indexPath.row == 5 {
//            SZHUD("正在开发中...", type: .info, callBack: nil)
//            navigationController?.pushViewController(XCashController(), animated: true)

            navigationController?.pushViewController(XMerPushSwitchController(), animated: true)
        }
        if indexPath.row == 6 {
            
            navigationController?.pushViewController(XAboutBearController(), animated: true)
        }
    }
}
extension XCenterController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        cropVC.customAspectRatio = CGSize(width:fit(122),height:fit(122))
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension  XCenterController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    self.imgPath = frontUrl + obk
                    self.topCell.headImg.kf.setImage(with: URL(string:self.imgPath ), for: .normal)
                    if self.imgPath != ""{
                        SNRequestBool(requestType: API.updateHeadPic(headImg: self.imgPath)).subscribe(onNext: {[unowned self] (result) in
                            switch result{
                            case .bool(let msg):
                                SZHUD(msg, type: .success, callBack: nil)
                                XKeyChain.set(self.imgPath, key: HEADIMG)
                            case .fail(let res):
                                UIAlertView(title: "温馨提示", message: res.msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                            default:
                                UIAlertView(title: "温馨提示", message: "请求错误", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                            }
                        }).disposed(by: self.disposeBag)
                    }
                    
                    SZHUDDismiss()
                }
            })
            
        }
        
    }
}



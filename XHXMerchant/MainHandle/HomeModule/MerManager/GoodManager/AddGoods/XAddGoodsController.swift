//
//  XAddGoodsController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/9.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController

class XAddGoodsController: SNBaseViewController {
    var filedCell:XAddGoodFieldCell = XAddGoodFieldCell()
    var desCell:XAddGoodDesCell = XAddGoodDesCell()
    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    fileprivate var detailImgArray:[String] = []
    fileprivate var mainImg:String = ""
    fileprivate var detailImg:String = ""
    var shopid:String = ""

    var model:GoodListModel?
    var tempString :String = ""
    var newDetail:[String] = []

    typealias PickedImageHandle = (UIImage) -> ()
    fileprivate var imagePickerFinishHandle: PickedImageHandle?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XAddGoodFieldCell.self)
        $0.register(XSpaceCell.self)
        $0.register(XAddGoodMainImgCell.self)
        $0.register(XAddGoodDetailCell.self)
        $0.register(XAddGoodDesCell.self)
        $0.register(XAddGoodSubmitCell.self)
    }
    
    fileprivate func setupUI() {
        self.title = "添加商品"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    func editData(){
        
        if filedCell.titleTextField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if filedCell.priceTextField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品价格", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if filedCell.cateTextField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请选择商品分类", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        var tempMainImg:String = ""
        if mainImg.isEmpty{
            tempMainImg = (self.model?.main_img)!
        }else{
            tempMainImg = mainImg
        }
        
        var tempDetailImg:String = ""
        if   detailImgArray.isEmpty{
            tempDetailImg = (self.model?.detail_img)!
        }else{
            tempDetailImg = newDetail.joined(separator: "|")
        }
        
//        guard !mainImg.isEmpty else {
//            UIAlertView(title: "温馨提示", message: "请上次商品主图", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
//            return
//        }
//        guard detailImgArray.count == 4 else {
//            UIAlertView(title: "温馨提示", message: "请选上传商品详情图", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
//            return
//        }
        if desCell.descriptionText.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品描述", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        let parameters:[String:Any] = ["name":filedCell.titleTextField.text!,
                                       "price":filedCell.priceTextField.text!,
                                       "cate":filedCell.cateTextField.text!,
                                       "main_img":tempMainImg,
                                       "detail_img":tempDetailImg,
                                       "description":desCell.descriptionText.text!,
                                       "shop_id":XKeyChain.get("SHOPID"),
                                       "id":(self.model?.id)!]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.editGood(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
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
    func uploadData(){
        
        detailImg = self.detailImgArray.joined(separator: "|")

        if filedCell.titleTextField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if filedCell.priceTextField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品价格", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if filedCell.cateTextField.text! == ""{
            UIAlertView(title: "温馨提示", message: "请选择商品分类", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard !mainImg.isEmpty else {
            UIAlertView(title: "温馨提示", message: "请上次商品主图", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard detailImgArray.count >= 1 else {
            UIAlertView(title: "温馨提示", message: "请选上传商品详情图", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        if desCell.descriptionText.text! == ""{
            UIAlertView(title: "温馨提示", message: "请输入商品描述", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        let parameters:[String:Any] = ["name":filedCell.titleTextField.text!,
                                       "price":filedCell.priceTextField.text!,
                                       "cate":filedCell.cateTextField.text!,
                                       "main_img":self.mainImg,
                                       "detail_img":self.detailImg,
                                       "description":desCell.descriptionText.text!,
                                       "shop_id":self.shopid]
        CNLog(parameters)
        
        SNRequestBool(requestType: API.addGood(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
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
    
    func receiveNotify(){
        let Notify = NSNotification.Name(rawValue:"GoodCate")
        NotificationCenter.default.addObserver(self, selector: #selector(getCateName(notify:)), name: Notify, object: nil)
    }
    @objc func getCateName(notify: NSNotification){
        guard let text: String = notify.object as! String? else { return }
        self.filedCell.cateTextField.text = text

    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    override func setupView() {
        setupUI()
        receiveNotify()
    }
}
extension XAddGoodsController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XAddGoodFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cateTextField.delegate = self
            if let cellModel = model {
                cell.titleTextField.text = cellModel.name
                cell.priceTextField.text = cellModel.price
                cell.cateTextField.text = cellModel.cate
            }
            self.filedCell = cell
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XAddGoodMainImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let cellModel = model{
                cell.logoImg.kf.setImage(with: URL(string: "\(cellModel.main_img)"), for: .normal)
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
       }else if indexPath.row == 4{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 5{
            let cell:XAddGoodDetailCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let cellModel = model{
                let detailImgArray = cellModel.detail_img.components(separatedBy:"|")
                if detailImgArray.count == 1{
                    cell.Img1.kf.setImage(with: URL(string: detailImgArray[0]), for: .normal)
                    cell.Img2.setImage(UIImage(named: "commodity_picture"), for: .normal)
                    cell.Img3.setImage(UIImage(named: "commodity_picture"), for: .normal)
                    cell.Img4.setImage(UIImage(named: "commodity_picture"), for: .normal)
                }else if detailImgArray.count == 2{
                    cell.Img1.kf.setImage(with: URL(string: detailImgArray[0]), for: .normal)
                    cell.Img2.kf.setImage(with: URL(string: detailImgArray[1]), for: .normal)
                    cell.Img3.setImage(UIImage(named: "commodity_picture"), for: .normal)
                    cell.Img4.setImage(UIImage(named: "commodity_picture"), for: .normal)
                }else if detailImgArray.count == 3{
                    cell.Img1.kf.setImage(with: URL(string: detailImgArray[0]), for: .normal)
                    cell.Img2.kf.setImage(with: URL(string: detailImgArray[1]), for: .normal)
                    cell.Img3.kf.setImage(with: URL(string: detailImgArray[2]), for: .normal)
                    cell.Img4.setImage(UIImage(named: "commodity_picture"), for: .normal)
                }else{
                    cell.Img1.kf.setImage(with: URL(string: detailImgArray[0]), for: .normal)
                    cell.Img2.kf.setImage(with: URL(string: detailImgArray[1]), for: .normal)
                    cell.Img3.kf.setImage(with: URL(string: detailImgArray[2]), for: .normal)
                    cell.Img4.kf.setImage(with: URL(string: detailImgArray[3]), for: .normal)
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
        }else if indexPath.row == 6{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 7{
            let cell:XAddGoodDesCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let cellModel = model{
                cell.descriptionText.text = cellModel.description
            }
            self.desCell = cell
            return cell
        }else{
            let cell:XAddGoodSubmitCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.submitBoutton.setTitle("提交", for: .normal)
            cell.submitBoutton.setTitleColor(Color(0xffffff), for: .normal)
            cell.clickBtnEvent = {[unowned self]  in
                if self.tempString == "1"{
                    self.uploadData()
                }else{
                    self.editData()
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return fit(0)
        }else if indexPath.row == 1{
            return fit(272)
        }else if indexPath.row == 2{
            return fit(20)
        }else if indexPath.row == 3{
            return fit(304)
        }else if indexPath.row == 4{
            return fit(20)
        }else if indexPath.row == 5{
            return fit(304)
        }else if indexPath.row == 6{
            return fit(20)
        }else if indexPath.row == 7{
            return fit(350)
        }else{
            return fit(214)
        }
    }
}
extension XAddGoodsController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        cropVC.customAspectRatio = CGSize(width:1,height:1)
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension XAddGoodsController : TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    let path = frontUrl + obk
                    if self.fullName == "1"{
                        self.mainImg = path
                    }else{
                        self.detailImgArray.append(path)
                    }
                    
                    //编辑
                    if let cellModel = self.model{
                        var newArray = cellModel.detail_img.components(separatedBy: "|")
                        
                        if  newArray.count == 1{
                            if self.fullName == "2"{
                                newArray.removeAll()
                                newArray.append(path)
                            }else{
                                newArray.append(path)
                            }
                        }else if newArray.count == 2{
                            if self.fullName == "2"{
                                newArray.remove(at: 0)
                                newArray.append(path)
                            }else if self.fullName == "3"{
                                newArray.remove(at: 1)
                                newArray.append(path)
                            }else{
                                newArray.append(path)
                            }
                        }else if newArray.count == 3{
                            if self.fullName == "2"{
                                newArray.remove(at: 0)
                                newArray.append(path)
                            }else if self.fullName == "3"{
                                newArray.remove(at: 1)
                                newArray.append(path)
                            }else if self.fullName == "4"{
                                newArray.remove(at: 2)
                                newArray.append(path)
                            }else{
                                newArray.append(path)
                            }
                        }else if newArray.count == 4{
                            if self.fullName == "2"{
                                newArray.remove(at: 0)
                                newArray.append(path)
                            }else if self.fullName == "3"{
                                newArray.remove(at: 1)
                                newArray.append(path)
                            }else if self.fullName == "4"{
                                newArray.remove(at: 2)
                                newArray.append(path)
                            }else{
                                newArray.remove(at: 3)
                                newArray.append(path)
                            }
                        }
                        self.newDetail = newArray

                    }
            
                }
            })
        }
    }
}

extension XAddGoodsController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = XGoodCateListController()
        vc.tempString = "1"
        self.navigationController?.pushViewController(vc, animated: true)
        return false
    }
}


//
//  XRcmdController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import PGActionSheet

class XRcmdController: SNBaseViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XRecmdCell.self)
        $0.register(XSpaceCell.self)
        
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationBar()
        
    }
    func saveImg(qrString : String ,icon : UIImage?){
        let alervc = UIAlertController(title: nil, message: "是否保存图片", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alervc.addAction(actionCancel)
        let actionCertain = UIAlertAction(title: "确定", style: .default) { (action) in
            UIImageWriteToSavedPhotosAlbum(ErCodeTool.creatQRCodeImage(text: qrString, size: fit(1000), icon: icon), self, #selector(self.saveFinshed(image:error:contextInfo:)), nil)
        }
        alervc.addAction(actionCertain)
//                present(alervc, animated: true, completion: nil)
//                jumpSubject.onNext(SNJumpType.present(vc: alervc, anmi: true))
        self.present(alervc, animated: true, completion: nil)
    }
    @objc func saveFinshed(image : UIImage,error : NSError?,contextInfo : Any){
        if error == nil{
            
            SZHUD("保存成功", type: .success, callBack: nil)
        }else{
            SZHUD("保存失败", type: .error, callBack: nil)
        }
    }
    
    fileprivate func setupUI() {
        
        self.title = "推荐"
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
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "推荐记录", imgName:"", target: self, action: #selector(login))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc fileprivate func login(){
        
        navigationController?.pushViewController(XRecmdRecordController(), animated: true)
    }
}
extension XRcmdController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell:XRecmdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
//                        cell.ercodeView.btnClick.subscribe(onNext: {[unowned self] (url) in
//                            self.saveImg(qrString: url, icon: nil)
//                        }).disposed(by: disposeBag)
            
            
            cell.clickEvent = { [unowned self] (para) in
                if para == 1{
                    let actionSheet =  PGActionSheet(cancelButton: true, buttonList: ["个体工商户", "企业单位"])
                    actionSheet.textColor = Color(0x313131)
                    actionSheet.textFont = Font(30)
                    actionSheet.translucent = false
                    actionSheet.actionSheetTranslucent = false
                    self.present(actionSheet, animated: false, completion: nil)
                    actionSheet.handler = {[unowned self] index in
                        //1:企业 2:个人
                        self.navigationController?.pushViewController(XMerBasicInfoController(), animated: true)
                        if index == 0{
                            XKeyChain.set("2", key: isConpany)
                        }else{
                            XKeyChain.set("1", key: isConpany)
                        }
                    }
                }
                if para == 2{
                    
                    let actionSheet =  PGActionSheet(cancelButton: true, buttonList: ["推荐运营商", "推荐服务商"])
                    actionSheet.textColor = Color(0x313131)
                    actionSheet.textFont = Font(30)
                    actionSheet.translucent = false
                    actionSheet.actionSheetTranslucent = false
                    self.present(actionSheet, animated: false, completion: nil)
                    actionSheet.handler = {[unowned self] index in
                        if index == 0{
                            self.navigationController?.pushViewController(XRcmdOperatorController(), animated: true)
                        }else{
                            self.navigationController?.pushViewController(XRecmdServiceController(), animated: true)
                        }
                    }
                    
                    
                }
            }
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(1594)
        }else{
            return fit(20)
        }
        
    }
}

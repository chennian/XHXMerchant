//
//  XHomeController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
class XHomeController: SNBaseViewController {
    
    var  model:[BannerModel] = []
    
    var  tokenModel :[TokenModel] = []    
    var userModel : [UserModel] = []

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XBannerCell.self)
        $0.register(XSpaceCell.self)
        $0.register(XListCell.self)
        $0.register(XFunctionCell.self)

        $0.separatorStyle = .none
    }
    
    fileprivate func setupUI() {
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        CNLog(XKeyChain.get(ISLOGIN))
        CNLog(XKeyChain.get(PHONE))
        if XKeyChain.get(ISLOGIN) == "0" || XKeyChain.get(ISLOGIN).isEmpty {
            self.navigationController?.pushViewController(XLoginController(), animated: false)
            return
        }else{
            self.submitLogin()
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func submitLogin(){
        SNRequest(requestType: API.login(phone:XKeyChain.get(PHONE) , password:XKeyChain.get(PASSWORD)), modelType: [TokenModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                SZHUDDismiss()
                self.tokenModel = models
                let token = self.tokenModel.map({return $0.token})
                let timestamp = self.tokenModel.map({return $0.timestamp})
                XKeyChain.set("1", key: ISLOGIN)
 
                XKeyChain.set(token[0], key: TOKEN)
                XKeyChain.set(timestamp[0], key:TIMESTAMP)
                self.getUserInfo()
                
            case .fail(let code,let msg):
                SZHUDDismiss()
                
                UIAlertView(title: "提示", message: msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                SZHUDDismiss()
                
                break
            }
        }).disposed(by: disposeBag)
        
    }
    
    func getUserInfo(){
        SNRequest(requestType: API.getUserInfo, modelType: [UserModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.userModel = models
                CNLog(models)
                let phone = self.userModel.map({return $0.phone})
                let isMer = self.userModel.map({return $0.isMer})
                let isAgent = self.userModel.map({return $0.isAgent})
                let roles = self.userModel.map({return $0.roles})
                let nikeName = self.userModel.map({return $0.nickName})
                let parentPhone = self.userModel.map({return $0.parent_phone})
                let operater = self.userModel.map({return $0.operater})
                let corporation = self.userModel.map({return $0.corporation})
                
                XKeyChain.set(isMer[0], key:IsMer )
                XKeyChain.set(isAgent[0], key:IsAgent )
                XKeyChain.set(roles[0], key:ROLE )
                XKeyChain.set(nikeName[0], key:NickName)
                XKeyChain.set(parentPhone[0], key:PARENTPHONE)
                XKeyChain.set(operater[0], key:OPERATER)
                XKeyChain.set(corporation[0], key:CORPORATION)
                CNLog(XKeyChain.get(IsAgent) + XKeyChain.get(OPERATER) + XKeyChain.get(CORPORATION))
                self.navigationController?.popViewController(animated: false)
                
            case .fail(_,let msg):
                SZHUD( msg ?? "获取个人信息失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "登录", imgName:"", target: self, action: #selector(login))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc fileprivate func login(){
        
        if XKeyChain.get(ISLOGIN) == "0" || XKeyChain.get(ISLOGIN).isEmpty {
            navigationController?.pushViewController(XLoginController(), animated: true)
        }else{
             UIAlertView(title: "温馨提示", message: "你已经是登录状态", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension XHomeController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XBannerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            CNLog(self.model)
//            cell.models = self.model
            return cell
        }else if indexPath.row == 1 {
            let cell:XFunctionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = { [unowned self] (para) in
                
                CNLog(XKeyChain.get(IsAgent) + XKeyChain.get(CORPORATION) + XKeyChain.get(OPERATER))
                
                if para == 1 {
                    SZHUD("正在开发中...", type: .info, callBack: nil)
//                    self.navigationController?.pushViewController(XPropertyController(), animated: true)
                }else if para == 2{
                    SZHUD("正在开发中...", type: .info, callBack: nil)
//                    self.navigationController?.pushViewController(XMerHomeController(), animated: true)
                }else if para == 3{
                    if XKeyChain.get(IsAgent) == "0" && XKeyChain.get(CORPORATION) == "0" && XKeyChain.get(OPERATER) == "0" {
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                     self.navigationController?.pushViewController(XFlowTeamController(), animated: true)
                }else if para == 4{
                    if XKeyChain.get(IsAgent) == "0" && XKeyChain.get(CORPORATION) == "0" && XKeyChain.get(OPERATER) == "0" {
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                    self.navigationController?.pushViewController(XFlowMerController(), animated: true)
                }else if para == 5{
                    if XKeyChain.get(IsAgent) == "0" && XKeyChain.get(CORPORATION) == "0" && XKeyChain.get(OPERATER) == "0" {
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                   self.navigationController?.pushViewController(XRcmdController(), animated: true)
                }else if para == 6{
                    if XKeyChain.get(IsAgent) == "1"{
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                    if XKeyChain.get(OPERATER) == "1"{
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                    if XKeyChain.get(CORPORATION) == "1"{
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                    self.navigationController?.pushViewController(XServiceRoleController(), animated: true)
                }else{
                    if XKeyChain.get(OPERATER) == "1"{
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                    if XKeyChain.get(CORPORATION) == "1"{
                        SZHUD("无权限", type: .info, callBack: nil)
                        return
                    }
                    self.navigationController?.pushViewController(XOperRoleController(), animated: true)

                }
            }
            return cell
        }else{
            let cell:XListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return fit(350)
        }else if indexPath.row == 1{
            return fit(845)
        }else{
            return fit(90)
        }
    }
}

//
//  XStaffCenterController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/24.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XStaffCenterController: SNBaseViewController {
    fileprivate var topCell:XCenterHeadCell = XCenterHeadCell()
    fileprivate var loginoutCell:XLoginOutCell = XLoginOutCell()
    
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
            topCell.name.text = XKeyChain.get(STAFFNAME)
        }
        
        if XKeyChain.get(PHONE) == "" || XKeyChain.get(PHONE).isEmpty{
            loginoutCell.loginOutBtn.setTitle("登录", for: .normal)
            topCell.phone.text = ""
        }else{
            loginoutCell.loginOutBtn.setTitle("退出登录", for: .normal)
            topCell.phone.text = XKeyChain.get(PHONE)

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

extension XStaffCenterController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XCenterHeadCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            topCell = cell
            if XKeyChain.get(PHONE) == ""{
                cell.name.text = "未登录"
            }else{
                cell.name.text = XKeyChain.get(STAFFNAME)
            }
            
            CNLog(XKeyChain.get(IsAgent) + XKeyChain.get(OPERATER) + XKeyChain.get(CORPORATION))
            if XKeyChain.get(PHONE) == ""{
                cell.phone.text = ""
            }else{
                cell.phone.text = XKeyChain.get(PHONE)
            }
            
            
            return cell
        }else if indexPath.row == 1 {
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            return cell
        }else if indexPath.row == 2 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "修改登录密码"
            cell.img.image = UIImage(named: "my_password")
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }else if indexPath.row == 3 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "推送开关"
            cell.img.image = UIImage(named: "my_switch")
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }else if indexPath.row == 4 {
            let cell:XCenterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "关于小黑熊商家版"
            cell.img.image = UIImage(named: "mu_regard")
            cell.accessoryType = .disclosureIndicator
            return cell
        }else if indexPath.row == 5{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:XLoginOutCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.loginoutCell = cell
            cell.clickEvent = {[unowned self] in
                
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
        }else if indexPath.row == 6{
            return fit(100)
        }else{
            return fit(90)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            navigationController?.pushViewController(XForgetPwdController(), animated: true)
        }
        if indexPath.row == 3 {
            navigationController?.pushViewController(XPushController(), animated: true)
        }
        if indexPath.row == 4 {
            navigationController?.pushViewController(XAboutBearController(), animated: true)
        }
    }
}

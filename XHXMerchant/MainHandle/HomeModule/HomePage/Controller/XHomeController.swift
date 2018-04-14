//
//  XHomeController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/5.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
class XHomeController: SNBaseViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupUI()
    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "登录", imgName:"", target: self, action: #selector(login))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc fileprivate func login(){
        
        navigationController?.pushViewController(XRcmdOperatorController(), animated: true)
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
            return cell
        }else if indexPath.row == 1 {
            let cell:XFunctionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = { [unowned self] (para) in
                if para == 1 {
                    CNLog("收益")
                }else if para == 2{
                    CNLog("店铺管理")
                }else if para == 3{
                    CNLog("流量团队")
                }else if para == 4{
                    CNLog("流量店铺")
                }else if para == 5{
                   self.navigationController?.pushViewController(XRcmdController(), animated: true)
                }else{
                    self.navigationController?.pushViewController(XRoleController(), animated: true)
                }
            }
            return cell
        }else if indexPath.row == 2 {
            let cell:XListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "收款码"
            return cell
        }else if indexPath.row == 3 {
            let cell:XListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "店铺管理"
            return cell
        }else if indexPath.row == 4 {
            let cell:XListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "收益"
            return cell
        }else if indexPath.row == 5 {
            let cell:XListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "流量管理"
            return cell
        }else if indexPath.row == 6 {
            let cell:XListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.lable.text = "修改密码"
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

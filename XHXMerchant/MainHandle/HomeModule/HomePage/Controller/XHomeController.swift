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
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "登录", imgName:"", target: self, action: #selector(login))
        navigationItem.rightBarButtonItem = barbutton
    }
    @objc fileprivate func login(){
        
        if XKeyChain.get(ISLOGIN) == "0"{
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
                if para == 1 {
                    self.navigationController?.pushViewController(XPropertyController(), animated: true)
                }else if para == 2{
                    self.navigationController?.pushViewController(XMerHomeController(), animated: true)
                }else if para == 3{
                     self.navigationController?.pushViewController(XFlowTeamController(), animated: true)
                }else if para == 4{
                    self.navigationController?.pushViewController(XFlowMerController(), animated: true)
                }else if para == 5{
                   self.navigationController?.pushViewController(XRcmdController(), animated: true)
                }else if para == 6{
                    self.navigationController?.pushViewController(XServiceRoleController(), animated: true)
                }else{
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

//
//  XRcmdOperatorController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XRcmdOperatorController: SNBaseViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XOperatorTopCell.self)
        $0.register(XOperatorEndCell.self)
        $0.register(XOperatorBtnCell.self)
        $0.register(XSpaceCell.self)
        
        $0.separatorStyle = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    fileprivate func setupUI() {
        
        self.title = "推荐运营商"
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
}
extension XRcmdOperatorController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:XOperatorTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 3{
            let cell:XOperatorEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 4{
            let cell:XOperatorBtnCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
   
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return fit(272)
        }else if indexPath.row == 3{
            return fit(453)
        }else if indexPath.row == 4{
            return fit(445)
        }else{
            return fit(20)
        }
        
    }
    
}

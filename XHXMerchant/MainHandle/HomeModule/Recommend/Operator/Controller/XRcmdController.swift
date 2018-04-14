//
//  XRcmdController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/14.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

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
            cell.clickEvent = { [unowned self] (para) in
                if para == 1{
                    self.navigationController?.pushViewController(XMerBasicInfoController(), animated: true)
                }
                if para == 2{
                      self.navigationController?.pushViewController(XRcmdOperatorController(), animated: true)
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

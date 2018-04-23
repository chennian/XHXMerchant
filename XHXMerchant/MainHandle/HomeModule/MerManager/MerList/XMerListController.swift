//
//  XMerListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import PGActionSheet

class XMerListController: SNBaseViewController {
    
    var models:[XMerListModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMerListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "店铺列表"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func loadData() {
        SNRequest(requestType: API.shopList, modelType: [XMerListModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.models = models
                self.tableView.reloadData()
            case .fail(let code,let msg):
                SZHUD(msg ?? "请求数据失败", type: .error, callBack: nil)
                if code == 1006 {
                    self.navigationController?.pushViewController(XLoginController(), animated: true)
                }
            default:
                break
            }
        }).disposed(by: disposeBag)
    }

    override func setupView() {
        setupUI()
        setNavigationBar()
    }
    @objc func addMer(){
        let actionSheet =  PGActionSheet(cancelButton: true, buttonList: ["分店", "个体工商户","企业单位"])
        actionSheet.textColor = Color(0x313131)
        actionSheet.textFont = Font(30)
        actionSheet.translucent = false
        actionSheet.actionSheetTranslucent = false
        self.present(actionSheet, animated: false, completion: nil)
        actionSheet.handler = {[unowned self] index in
            if index == 0{
                self.navigationController?.pushViewController(XAddMerController(), animated: true)
            }else if index == 1{   //1:企业 2:个人
                let vc = XAddMerBaseInfoController()
                XKeyChain.set("2", key: isConpany)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = XAddMerBaseInfoController()
                XKeyChain.set("1", key: isConpany)

                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "新增店铺", imgName:"", target: self, action: #selector(addMer))
        navigationItem.rightBarButtonItem = barbutton
    }
}

extension XMerListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XMerListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = self.models[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(228)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = XMerHomeController()
        vc.shopID = self.models[indexPath.row].shop_id
        vc.logo = self.models[indexPath.row].logo
        vc.shopName = self.models[indexPath.row].shopName
        vc.personal = self.models[indexPath.row].personal
        vc.flow_num = self.models[indexPath.row].flow_num
        vc.merListModel = self.models[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView().then{
            $0.backgroundColor = Color(0xf5f5f5)
        }
        return view
    }
    
}

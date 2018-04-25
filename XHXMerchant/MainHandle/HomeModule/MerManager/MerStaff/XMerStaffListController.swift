//
//  XMerStaffListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/19.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerStaffListController: SNBaseViewController {
    var shop_id:String = ""
    var models :[XMerStaffList] = []
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMerStaffListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "员工列表"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    override func loadData() {
        CNLog(self.shop_id)
        SNRequest(requestType: API.getShopEmployeeList(shop_id:self.shop_id), modelType: [XMerStaffList.self]).subscribe(onNext: {[unowned self] (result) in
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
    @objc func addStaff(){
       let vc =  XMerAddStaffController()
        vc.shop_id = self.shop_id
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    fileprivate func setNavigationBar(){
        let barbutton = UIBarButtonItem.init(title: "新增", imgName:"", target: self, action: #selector(addStaff))
        navigationItem.rightBarButtonItem = barbutton
    }
}

extension XMerStaffListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XMerStaffListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.num.text = "\(indexPath.row + 1)"
        if indexPath.row % 2 == 0{
            cell.imgview.backgroundColor = Color(0xff566e)
        }else{
            cell.imgview.backgroundColor = Color(0x2c7bff)
        }
        cell.model = self.models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(148)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = XMerAddStaffController()
        vc.model = self.models[indexPath.row]
        vc.shop_id = self.models[indexPath.row].shop_id
        vc.temp = "1"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

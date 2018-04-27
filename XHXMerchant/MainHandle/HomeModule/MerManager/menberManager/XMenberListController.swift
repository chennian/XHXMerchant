//
//  XMenberListController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/26.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMenberListController: SNBaseViewController {
    
    var alipayModel :[XMenberListModel] = []
    var weixinModel :[XMenberListModel] = []
    
    var model:[XMenberListModel] = []

    var shopid:String = ""
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XMenberListCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "我的会员"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    func getData(){
        SNRequest(requestType: API.getShopMemberList(shopId: shopid), modelType: [MenberTypeModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.alipayModel = models[0].alipay
                self.weixinModel = models[0].weichat
                if !models[0].weichat.isEmpty{
                    for item in self.weixinModel{
                        self.alipayModel.append(item)
                    }
                }
               
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
        getData()
        setupUI()
    }
}

extension XMenberListController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alipayModel.count
//          return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XMenberListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = self.alipayModel[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(195)
    }
    
}
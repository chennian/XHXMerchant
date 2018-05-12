//
//  XMerHomeController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/16.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XMerHomeController: SNBaseViewController {
    var shopID:String = ""
    var logo:String = ""
    var shopName:String = ""
    var personal:String = ""
    var flow_num:String = ""
    
    var merListModel:XMerListModel?
    
    var model:[XMerListModel] = []
    let headerCell:MerHeaderCell = MerHeaderCell()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(MerHomeTopCell.self)
        $0.register(MerHomeEndCell.self)
        $0.register(MerHeaderCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    fileprivate func setupUI() {
        self.title = "店铺首页"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }

    override func loadData() {
        SNRequest(requestType: API.shopHome(shopId:shopID), modelType: [XMerListModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
                self.tableView.reloadData()
            case .fail(let code ,let msg):
                SZHUD(msg ?? "获取数据失败", type:.error, callBack: nil)
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
}

extension XMerHomeController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:MerHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if !self.model.isEmpty{
                cell.model = self.model[0]
            }
            return cell
        }else if indexPath.row == 1{
            let cell:MerHomeTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = {[unowned self] (para) in
                if para == "1"{
                    let vc  = XMerReciptCodeController()
                    vc.shop_ID = self.shopID
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == "2"{
                    let vc = XMerDataController()
                    CNLog((self.merListModel?.shop_id)!)
                    vc.shopId = (self.merListModel?.shop_id)!
                    vc.model = self.model
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == "3"{
                    let vc = XAddSeckillListController()
                    vc.shopid = (self.merListModel?.shop_id)!
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = XGoodListController()
                    vc.shopid = (self.merListModel?.shop_id)!
                    XKeyChain.set((self.merListModel?.shop_id)!, key: "SHOPID")
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            }
            return cell
        }else if indexPath.row == 2 {
            let cell:MerHomeEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = {[unowned self] (para) in
                if para == "1"{
                    //会员管理
                    
                    let vc = XMenberListController()
                    vc.shopid = (self.merListModel?.shop_id)!
                   self.navigationController?.pushViewController(vc, animated: true)
                }else if para == "2"{
                    let vc = XMerStaffListController()
                    vc.shop_id = (self.merListModel?.shop_id)!
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == "3"{
                    let vc = XCouponCancerController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.navigationController?.pushViewController(XGoodCateListController(), animated: true)
                }
            }
            return cell
        }else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(450)
        }else if indexPath.row == 1{
            return fit(430)
        }else if indexPath.row == 2{
            return fit(430)
        }else{
            return fit(20)
        }
    }
    
}

//
//  XPropertyController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/10.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XPropertyController: SNBaseViewController {
    
    var monthModel:[monthModel] = []
    var todayModel:[todayModel] = []
    var historyModel:[historyModel] = []

    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XTotalEarningTopCell.self)
        $0.register(XTotalEarningsMidCell.self)
        $0.register(XTotalEarningsEndCell.self)
        $0.register(XTotalEarningEndDetailCell.self)
        $0.register(XSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    fileprivate func setupUI() {
        self.title = "资产管理"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    override func loadData() {
        SNRequest(requestType: API.monthTotalRevenue, modelType: [TotalModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                if models.isEmpty {return}
                self.monthModel = models[0].month
                self.todayModel = models[0].today
                self.historyModel = models[0].history

                self.tableView.reloadData()
            case .fail(_ ,let msg):
                SZHUD(msg ?? "获取数据失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    override func setupView() {
        setupUI()
        loadData()
    }
}

extension XPropertyController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:XTotalEarningTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if !self.monthModel.isEmpty{
                cell.models = self.monthModel[0]
            }else{
                
            }
            return cell
        }else if indexPath.row == 1{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2{
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent1 = {[unowned self] () in
                CNLog(123)
                self.navigationController?.pushViewController(XDayEarningController(), animated: true)
            }
            return cell
        }else if indexPath.row == 3{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 4{
            let cell:XTotalEarningsEndCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.btnClickEvent = {[unowned self] () in
                CNLog(1)
                self.navigationController?.pushViewController(XEarningDetailController(), animated: true)
            }
            return cell
        }else if indexPath.row == 5{
            let cell:XTotalEarningEndDetailCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = self.historyModel
            return cell
        }
        else{
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return fit(452)
        }else if indexPath.row == 1{
            return fit(20)

        }else if indexPath.row == 2{
            return fit(701)
            
        }else if indexPath.row == 3{
            return fit(20)
        }else if indexPath.row == 4{
            return fit(100)
            
        }else if indexPath.row == 5{
            return fit(242)
        }else{
            return fit(450)
        }
    }
}


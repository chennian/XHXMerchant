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
    
    var cellType :[propertyType] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XTotalEarningTopCell.self)
        $0.register(XTotalEarningsMidCell.self)
        $0.register(XTotalEarningMidHeaderCell.self)

        $0.register(XTotalEarningsListHeaderCell.self)
        $0.register(XTotalEarningsListCell.self)
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

                self.cellType.removeAll()
                self.cellType.append(.hearder(self.monthModel[0]))
                self.cellType.append(.space)
                
                self.cellType.append(.todayHead(self.todayModel[0]))
                if !self.todayModel[0].merchant.isEmpty{
                    self.cellType.append(.merchant(["商家货款",self.todayModel[0].merchant,self.todayModel[0].merchant_num]))
                }
                if !self.todayModel[0].service.isEmpty{
                     self.cellType.append(.service(["服务商分润",self.todayModel[0].service,self.todayModel[0].service_num]))
                }
                if !self.todayModel[0].operater.isEmpty{
                    self.cellType.append(.operation(["运营商分润",self.todayModel[0].operater,self.todayModel[0].operator_num]))
                }
                if !self.todayModel[0].flowmeter.isEmpty{
                    self.cellType.append(.merchantFlow(["商家导流分润",self.todayModel[0].flowmeter,self.todayModel[0].flow_num]))
                }
                if !self.todayModel[0].corporation.isEmpty{
                    self.cellType.append(.center(["服务中心分润",self.todayModel[0].corporation,self.todayModel[0].corporation_num]))
                }
                
                self.cellType.append(.space)
                self.cellType.append(.historyHead)
                if !self.historyModel.isEmpty{
                    for item  in self.historyModel{
                        self.cellType.append(.history(item))
                    }
                    
                }
                
                CNLog(self.cellType.count)
                
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
        return self.cellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case let .hearder(model):
            let cell:XTotalEarningTopCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = model
            return cell
        case let .todayHead(model):
            let cell:XTotalEarningMidHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
            /*****************************根据类型判断功能*************************************/
        case let .merchant(profit):
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = profit
            return cell
        case let .merchantFlow(profit):
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = profit
            return cell
        case let .service(profit):
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = profit
            return cell
        case let .operation(profit):
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = profit
            return cell
        case let .center(profit):
            let cell:XTotalEarningsMidCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = profit
            return cell
       /*-------------------------------------------------------------------------------*/
        case  .space:
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .historyHead:
            let cell:XTotalEarningsListHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case let .history(model):
            let cell:XTotalEarningsListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = model
            return cell
        default:
            let cell:XSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CNLog(self.cellType[indexPath.row])
        switch self.cellType[indexPath.row] {
        case let .todayHead(model):
            let vc = XDayEarningController()
            vc.total = model.money
            navigationController?.pushViewController(vc, animated: true)
        case .merchant:
            navigationController?.pushViewController(XMerRevenueController(), animated: true)
        case .merchantFlow:
            navigationController?.pushViewController(XFlowRevenueController(), animated: true)
        case .service:
            navigationController?.pushViewController(XServiceRevenueController(), animated: true)
        case .operation:
            navigationController?.pushViewController(XOperRevenueController(), animated: true)
        case .center:
            navigationController?.pushViewController(XCenterRevenueController(), animated: true)
        case .historyHead:
            navigationController?.pushViewController(XHistoryDetailController(), animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.cellType[indexPath.row] {
        case .hearder:
            return fit(452)
        case .todayHead:
            return fit(96)
        case .history:
            return fit(120)
        case .historyHead:
            return fit(96)
        case .space:
            return fit(20)
        default:
            return fit(120)
        }
    }
   }

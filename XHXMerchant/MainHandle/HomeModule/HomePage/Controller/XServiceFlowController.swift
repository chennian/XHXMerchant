//
//  XServiceFlowController.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/5/7.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class XServiceFlowController: SNBaseViewController {

    var model :[FlowTeamModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(XFlowTeamCell.self)
        $0.register(XSpaceCell.self)
        $0.tableFooterView = UIView()
    }
    
    fileprivate func setupUI() {
        self.title = "团队流量"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    func getData(){
        SNRequest(requestType: API.flowTeam(role:"1"), modelType: [FlowTeamModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let models):
                self.model = models
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

extension XServiceFlowController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:XFlowTeamCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.models = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(128)
    }
    
}
